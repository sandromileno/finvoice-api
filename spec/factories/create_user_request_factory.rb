FactoryBot.define do
  factory :create_user_request, class: Hash do
    initialize_with do
      {
        user:
          {
            email: "#{SecureRandom.uuid}@gmail.com",
            password: '123456',
            password_confirmation: '123456'
          }
      }
    end
  end
end
