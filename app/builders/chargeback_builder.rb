class ChargebackBuilder
  def self.build(params)
    invoice = Invoice.by_invoice_id_and_customer_id(params[:invoice_id], params[:customer_id]).first
    raise ResourceNotFound if invoice.nil?
    Chargeback.new(amount: params[:amount], invoice_id: invoice.id, reason: params[:reason])
  end
end