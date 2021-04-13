class PaidInvoiceBusinessError < BusinessError
  def initialize
    super(I18n.t(:paid_invoice))
  end
end