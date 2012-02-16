Factory.define :user do |u|
  u.name 'Uranie'
  u.sequence(:email) {|n| "user#{n}@example.com" }
  u.password "password"
end

