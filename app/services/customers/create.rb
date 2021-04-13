class Customers::Create
  def self.execute(customer)
    customer.save()
    customer
  rescue StandardError => e
    Rails.logger.error(e.message)
    raise DatabaseIntegrationError
  end
end
