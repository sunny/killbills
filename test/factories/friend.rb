# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend do
    name 'Friend'
    association :user
  end
end

