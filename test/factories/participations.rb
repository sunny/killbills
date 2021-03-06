# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participation do
    association :bill
    payment 42
    owed_type "all"
    owed_amount nil
    owed_percent nil
    association :person, factory: :friend
  end

  trait :from_user do
    association :person, factory: :user
  end

  trait :paying do
    payment 42
    owed_type "zero"
  end

  trait :getting do
    payment 0
    owed_type "all"
  end

  trait :even do
    owed_type "even"
  end
end

