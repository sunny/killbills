# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name "User"
    email
    password "password"
    currency "USD"
  end
end

