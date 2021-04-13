class InvoiceAlreadyChargebackedBusinessError < BusinessError
  def initialize
    super(I18n.t(:invoice_already_chargebacked))
  end
end