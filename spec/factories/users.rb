FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "Password123!" }
    password_confirmation { password }
    is_admin { false }
  end
end
