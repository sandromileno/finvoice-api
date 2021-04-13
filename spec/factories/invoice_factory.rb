FactoryBot.define do
  factory :invoice do
    id
    amount { 200.4 }
    external_key  { SecureRandom.uuid }
    paid { 0 }
    chargebacked { 0 }
    status { "PENDING" }
    scan { "htp://test.com/img.png" }
  end
end