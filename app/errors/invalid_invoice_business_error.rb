class InvalidInvoiceBusinessError < BusinessError
  def initialize
    super(I18n.t(:invalid_invoice))
  end
end