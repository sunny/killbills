class Participation < ActiveRecord::Base
  # Associations
  belongs_to :bill, touch: true
  belongs_to :person
  has_one :user, through: :bill

  # Attributes
  include Enumerize
  include ActiveModel::ForbiddenAttributesProtection
  enumerize :owed_type, in: [:even, :zero, :all, :fixed], default: :even

  # Hooks
  before_save :remove_unused_attributes

  # Validations
  validates :person_id,
    presence: true,
    uniqueness: { scope: :bill_id }

  validates :payment,
    numericality: {
      greater_than_or_equal_to: 0,
      allow_blank: true
    }

  validates :owed_percent,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    presence: true,
    if: :percentage?

  validates :owed_amount,
    numericality: { greater_than_or_equal_to: 0 },
    presence: true,
    if: :fixed?

  # Scopes
  scope :unshared, -> { where("participations.owed_type != 'even'") }
  scope :shared,   -> { where(owed_type: "even") }

  scope :friends, -> { includes(:person).where(people: { type: 'Friend' }) }
  scope :users,   -> { includes(:person).where(people: { type: 'User' }) }

  def shared?
    owed_type == "even"
  end

  def percentage?
    owed_type == "percentage"
  end

  def fixed?
    owed_type == "fixed"
  end

  # Depending on the chosen calculation for owed
  # returns the total amount the person owes
  def owed_total
    case owed_type
      when "even"       then bill.even_share
      when "zero"       then 0
      when "all"        then bill.total
      when "percentage" then bill.total * owed_percent.to_f / 100
      when "fixed"      then owed_amount
      else 0
    end.to_f
  end

  # What the person needs to pay back
  # FIXME does not account for different genres on Bill
  def debt
    owed_total - payment.to_f
  end

  def remove_unused_attributes
    if bill
      self.owed_amount = nil if bill.genre.payment?
      self.payment = nil     if bill.genre.debt?
    end
  end
end
