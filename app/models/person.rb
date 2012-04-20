class Person < ActiveRecord::Base
  has_many :participations, dependent: :destroy

  def title
    name || email
  end
end

