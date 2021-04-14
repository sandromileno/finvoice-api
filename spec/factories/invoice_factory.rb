FactoryBot.define do
  factory :invoice, class: Invoice do
    amount { 200.4 }
    external_key  { SecureRandom.uuid }
    key { SecureRandom.uuid }
    due_date { Time.now.utc }
    paid { 0 }
    chargebacked { 0 }
    status { "PENDING" }
    scan { "htp://test.com/img.png" }
    customer
  end
end