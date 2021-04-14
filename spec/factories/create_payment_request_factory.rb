FactoryBot.define do
  factory :create_payment_request, class: Hash do
    initialize_with do
      {
        amount: 134.56
      }
    end
  end
end