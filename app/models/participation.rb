class Participation < ActiveRecord::Base
  # Associations
  belongs_to :bill, touch: true
  belongs_to :person, touch: true
  has_one :user, through: :bill

  # Validations
  validates :person_id,
    presence: true,
    uniqueness: { scope: :bill_id }

  validates :owed,
    presence: true,
    inclusion: { in: %w(even zero all percentage fixed) }

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
  scope :unshared, where("participations.owed != 'even'")
  scope :shared, where(owed: "even")

  scope :friends, includes(:person).where(people: { type: 'Friend' })
  scope :users,   includes(:person).where(people: { type: 'User' })

  def shared?
    owed == "even"
  end

  def percentage?
    owed == "percentage"
  end

  def fixed?
    owed == "fixed"
  end

  # Depending on the chosen calculation for owed
  # return the total amount the person owes
  def owed_total
    case owed
      when "even"       then bill.even_share
      when "zero"       then 0
      when "all"        then bill.total
      when "percentage" then bill.total * owed_percent.to_f / 100
      when "fixed"      then owed_amount
      else
        0
    end.to_f
  end

  # What the person needs to pay back
  def debt
    owed_total - payment.to_f
  end

  # Calculation methods to show in a select box
  # for how much the person owes
  def self.owed_for_select
    {
      "even"  => "Even share",
      "zero"  => "Nothing",
      "all"   => "Everything",
      #"percentage" => "A percentage",
      #"fixed" => "Fixed amount",
    }.map { |k,v| [v,k] }
  end
end

