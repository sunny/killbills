# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participation do
    association :bill
    payment 42
    owed :all
    owed_amount nil
    owed_percent nil
  end

  factory :user_participation, :parent => :participation do
    association :person, :factory => :user
  end

  factory :user_giver_participation, :parent => :user_participation do
    payment 42
    owed :all
  end

  factory :friend_participation, :parent => :participation do
    association :person, :factory => :friend
  end

  factory :friend_getter_participation, :parent => :friend_participation do
    payment 0
    owed :zero
  end
end

