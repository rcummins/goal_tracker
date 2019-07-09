FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password { Faker::Internet.password(8) }
  end
end
