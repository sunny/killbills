class Person < ActiveRecord::Base
  # Associations
  has_many :participations, foreign_key: :person_id

  # Attributes
  include ActiveModel::ForbiddenAttributesProtection

  def display_name
    name || email
  end
end

