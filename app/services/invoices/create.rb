class Invoices::Create
  def self.execute(invoice, scan)
    raise DuplicatedInvoiceIdentifierBusinessError if Invoice.by_external_key_and_customer_id(invoice.external_key, invoice.customer_id).first.present?
    begin
      Invoice.transaction do
        if (scan)
          invoice.save()
          invoice.document.attach(scan)
          invoice.scan = Rails.application.routes.url_helpers.url_for(invoice.document)
        end
        invoice.save()
        invoice
      end
    rescue StandardError => err
      Rails.logger.error(err.message)
      raise DatabaseIntegrationError
    end
  end
end