# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    user
    genre "shared"
    #title "Title"
    #date
  end

  trait :debt do
    genre "debt"
  end

  trait :shared do
    genre "shared"
  end

  trait :payment do
    genre "payment"
  end

  trait :with_friend do
    after :create do |bill|
      create :participation, bill: bill
    end
  end

  trait :with_paying_friend do
    after :create do |bill|
      create :participation, bill: bill, payment: 42
    end
  end

  trait :with_user do
    after :create do |bill|
      create :participation, bill: bill, person: bill.user
    end
  end

  trait :with_paying_user do
    after :create do |bill|
      create :participation, bill: bill, person: bill.user, payment: 42
    end
  end

end
