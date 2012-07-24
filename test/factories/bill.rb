# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    user
    genre "shared"
    #title "Title"
    #date
  end

  trait :with_debt_user_to_friend do
    after :create do |bill|
      FactoryGirl.create :participation, :getting, bill: bill
      FactoryGirl.create :participation, :paying, :from_user, bill: bill
    end
  end

  trait :with_debt_friend_to_user do
    after :create do |bill|
      FactoryGirl.create :participation, :paying, bill: bill
      FactoryGirl.create :participation, :getting, :from_user, bill: bill
    end
  end

  trait :with_debt_friend_and_user do
    after :create do |bill|
      FactoryGirl.create :participation, :paying, bill: bill
      FactoryGirl.create :participation, :paying, :from_user, bill: bill
    end
  end

  trait :with_debt_three_friends_and_user do
    after :create do |bill|
      3.times { FactoryGirl.create :participation, :paying, bill: bill }
      FactoryGirl.create :participation, :paying, :from_user, bill: bill
    end
  end
end
