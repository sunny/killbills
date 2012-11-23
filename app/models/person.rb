class Person < ActiveRecord::Base
  # Associations
  has_many :participations, foreign_key: :person_id

  def display_name
    name || email
  end
end

