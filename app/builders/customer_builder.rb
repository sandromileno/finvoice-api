class CustomerBuilder
  def self.build(params)
    Customer.new(params.permit(:document, :full_name, :user_id))
  end
end