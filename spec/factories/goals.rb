FactoryBot.define do
  factory :goal do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    due_date { Faker::Time.forward(100, :morning) }
    is_private { Faker::Boolean }
    completed { false }
  end
end
