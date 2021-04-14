class Chargebacks::Create
  def self.execute(chargeback)
    Chargeback.transaction do
      invoice = Invoice.by_invoice_id(chargeback.invoice_id)
      chargeback = invoice.add_chargeback(chargeback)
      invoice.save()
      chargeback
    end
  rescue BusinessError
    raise
  rescue StandardError => err
    Rails.logger.error(err.message)
    raise DatabaseIntegrationError
  end
end