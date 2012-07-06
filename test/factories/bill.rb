# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    user
    #title "Title"
    #date
  end

  trait :with_user_giving_friend do
    after :create do |bill|
      FactoryGirl.create :user_giver_participation, :bill => bill
      FactoryGirl.create :friend_getter_participation, :bill => bill
    end
  end
end
