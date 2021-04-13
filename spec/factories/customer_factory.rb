FactoryBot.define do
  factory :customer do
    key { SecureRandom.uuid }
    full_name { 'Test name' }
    document { rand(1000000...9999999).to_s }
    user
  end
end