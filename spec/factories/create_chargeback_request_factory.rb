FactoryBot.define do
  factory :create_chargeback_request, class: Hash do
    initialize_with do
      {
        amount: 134.56,
        reason: 'Test'
      }
    end
  end
end
