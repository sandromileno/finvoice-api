class Payments::Create
  def self.execute(payment)
    Payment.transaction do
      invoice = Invoice.by_invoice_id(payment.invoice_id)
      payment = invoice.add_payment(payment)
      invoice.save()
      payment
    end
  rescue BusinessError
    raise
  rescue StandardError => err
    Rails.logger.error(err.message)
    raise DatabaseIntegrationError
  end
end