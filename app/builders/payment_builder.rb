class PaymentBuilder
  def self.build(params)
    invoice = Invoice.by_invoice_id_and_customer_id(params[:invoice_id], params[:customer_id]).first
    raise ResourceNotFound if invoice.nil?
    Payment.new(amount: params[:amount], invoice_id: invoice.id)
  end
end