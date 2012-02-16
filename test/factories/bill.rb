# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    title 'Coffee'
    date 2.days.ago
    association :user
  end
end

