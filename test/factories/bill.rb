# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    title 'Coffee'
    amount 42
    date 2.days.ago
    association :user
    association :friend
    user_payed 0
    friend_payed 42
    user_ratio 1
  end
end

