FactoryBot.define do
  factory :create_invoice_request, class: Hash do
    initialize_with do
      {
        due_date: Time.now.utc,
        amount: 12.50,
        external_key: SecureRandom.uuid,
        scan: Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/attachments/rocket.png", 'image/png')
      }
    end
  end
end