# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Uranie"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
  end
end

