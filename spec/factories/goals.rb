FactoryBot.define do
  factory :goal do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    due_date { Faker::Time.forward(100, :morning) }
    privacy { 'Public' }
    completion { 'Not completed' }
  end
end
