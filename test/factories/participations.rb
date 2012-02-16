# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participation do
    association :bill
    association :person
    payment 42
    owed "all"
    owed_amount nil
    owed_percent nil
  end

  factory :friend_participation, :parent => :participation do
    association :person, :factory => :friend
  end

  factory :user_participation, :parent => :participation do
    association :person, :factory => :user
  end
end

