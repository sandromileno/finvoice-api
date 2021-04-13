class DuplicatedInvoiceIdentifierBusinessError < BusinessError
  def initialize
    super(I18n.t(:duplicated_invoice_identifier))
  end
end