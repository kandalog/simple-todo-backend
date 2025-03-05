FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.sentence }
    is_completed { false }
    association :user
  end
end
