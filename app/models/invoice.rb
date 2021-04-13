class Invoice < ApplicationRecord
  include ErrorConverter

  STATUS = [PENDING = 'PENDING', PAID = 'PAID', CHARGEBACKED = 'CHARGEBACKED', INVALID = 'INVALID'].freeze

  # associations
  belongs_to :customer
  has_many :payments, dependent: :destroy
  has_many :chargebacks, dependent: :destroy
  has_one_attached :document, dependent: :destroy

  # validations
  validates :external_key, :amount, :paid, :due_date, presence: true
  validates :external_key, length: { maximum: 255 }
  validates :amount, :paid, numericality: true

  # queries
  scope :by_invoice_id_and_customer_id, (->(invoice_id, customer_id) { select('invoices.id, invoices.amount, invoices.paid, invoices.scan, invoices.status, invoices.key, invoices.external_key')
                                                                         .joins(:customer).where(customers: { key: customer_id }, invoices: { key: invoice_id }).limit(1) })
  scope :by_invoice_id, (->(invoice_id) { where(id: invoice_id ).first })
  scope :by_external_key_and_customer_id, (->(external_key, customer_id) { where(external_key: external_key, customer_id: customer_id ).limit(1) })

  # triggers
  after_initialize :configure_unique_key, :initial_status

  def add_payment(payment)
    raise ChargebackedInvoiceBusinessError if chargebacked?
    raise InvalidInvoiceBusinessError if invalid?
    raise PaidInvoiceBusinessError if paid?
    raise InvalidPaymentAmountBusinessError if (self.paid + payment.amount) > self.amount

    self.paid += payment.amount
    persisted_payment = self.payments.build(key: payment.key, amount: payment.amount)
    change_status_to_paid_if_necessary()
    persisted_payment
  end

  def add_chargeback(chargeback)
    raise InvoiceAlreadyChargebackedBusinessError if chargebacked?
    raise ChargebackExceedsBusinessError if (self.chargebacked + chargeback.amount) > self.amount

    self.chargebacked += chargeback.amount
    chargeback = self.chargebacks.build(amount: chargeback.amount, reason: chargeback.reason)
    change_status_to_chargeback_if_necessary()
    chargeback
  end

  def chargebacked?
    Invoice::CHARGEBACKED.eql?(self.status)
  end

  def invalid?
    Invoice::INVALID.eql?(self.status)
  end

  def paid?
    Invoice::INVALID.eql?(self.status)
  end

  def pending?
    Invoice::PENDING.eql?(self.status)
  end

  def invalidate!
    raise InvalidStatusChangeBusinessError if has_payments? || !pending?
    self.status = Invoice::INVALID
  end

  def change_amount!(amount)
    raise "" if amount > self.paid && !pending?
    self.amount = amount
  end

  def has_payments?
    self.paid != 0
  end

  protected

  def change_status_to_chargeback_if_necessary
    self.status = Invoice::CHARGEBACKED if self.amount.eql?(self.chargebacked)
  end

  def change_status_to_paid_if_necessary
    self.status = Invoice::PAID if self.amount.eql?(self.paid)
  end

  def initial_status
    self.status ||= Invoice::PENDING
  end

  def configure_unique_key
    self.key ||= SecureRandom.uuid
    self.external_key ||= SecureRandom.uuid
  end
end
