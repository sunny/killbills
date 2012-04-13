class Person < ActiveRecord::Base
  has_many :participations

  def title
    name || email
  end
end

