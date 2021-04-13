class InvoiceBuilder
  def self.build(params)
    customer = Customer.find_by(key: params[:customer_id])
    raise ResourceNotFound if customer.blank?
    Invoice.new(params.merge(customer_id: customer.id).permit(:external_key, :amount, :due_date, :customer_id))
  end
end