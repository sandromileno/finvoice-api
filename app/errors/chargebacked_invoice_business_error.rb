class ChargebackedInvoiceBusinessError < BusinessError
  def initialize
    super(I18n.t(:chargebacked_invoice))
  end
end