Factory.define :bill do |b|
  b.title 'Coffee'
  b.amount 42
  b.date 2.days.ago
  b.association :user, :factory => :user
  b.association :friend, :factory => :friend
  b.user_payed 0
  b.friend_payed 42
  b.user_ratio 1
end

