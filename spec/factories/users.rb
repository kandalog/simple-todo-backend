FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'Password1234!' }
    password_confirmation { 'Password1234!' }
  end
end
