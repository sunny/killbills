class User < ActiveRecord::Base
  has_many :bills
end
