class Person < ActiveRecord::Base
  # Associations
  has_many :participations, foreign_key: :person_id

  # Attributes
  include ActiveModel::ForbiddenAttributesProtection
  include Enumerize
  enumerize :currency, in: %w(USD EUR), default: 'USD'

  def currency_unit
    currency.try(:text) || "$"
  end
end

