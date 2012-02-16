Factory.define :friend do |f|
  f.name 'Friday'
  f.association :user, :factory => :user
end

