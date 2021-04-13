FactoryBot.define do
  factory :chargeback do
    amount { 10.4 }
    reason { 'test' }

    trait :with_invoice do
      after(:create) { |c| FactoryBot.create(:invoice) }
    end
  end
end
