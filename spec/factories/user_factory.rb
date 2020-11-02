FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { 'supersecret123' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    trait :admin do
      role { User.roles[:admin] }
    end
  end
end
