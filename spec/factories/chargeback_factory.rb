FactoryBot.define do
  factory :chargeback do
    amount { 10.4 }
    reason { 'test' }
    key { SecureRandom.uuid }
  end
end
