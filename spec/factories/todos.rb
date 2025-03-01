FactoryBot.define do
  factory :todo do
    title { 'test' }
    content { 'test' }
    is_completed { false }
    association :user
  end
end
