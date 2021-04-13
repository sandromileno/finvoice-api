class ChargebackExceedsBusinessError < BusinessError
  def initialize
    super(I18n.t(:chargeback_amount_exceeds_invoice_amount))
  end
end