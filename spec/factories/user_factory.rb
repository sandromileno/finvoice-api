FactoryBot.define do
  factory :user do
    email { "#{SecureRandom.uuid}@test.com" }
    password { rand(1000000...9999999).to_s }
    encrypted_password { rand(1000000...9999999).to_s }
  end
end
