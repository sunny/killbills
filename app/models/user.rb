class User < Person
  has_many :bills
  has_many :friends
end
