# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend do
    name 'Friday'
    association :user
  end
end

