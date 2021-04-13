class Invoices::Update
  def self.execute(invoice, params: {})
    Invoice.transaction do
      invoice = Invoice.find(invoice.id)
      invoice.invalidate! if params[:status].present?
      invoice.change_amount!(params[:amount]) if params[:amount].present?
      invoice.save
      invoice
    end
  rescue BusinessError
    raise
  rescue StandardError => err
    Rails.logger.error(err.message)
    raise DatabaseIntegrationError
  end
end