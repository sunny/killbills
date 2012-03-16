class Participation < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person


  validates :person_id,
    presence: true,
    uniqueness: { scope: :bill_id }

  validates :owed,
    presence: true,
    inclusion: { in: %w(even zero all percentage fixed) }

  validates :payment,
    numericality: { greater_than_or_equal_to: 0 }

  validates :owed_percent,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    if: :percentage?

  validates :owed_amount,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 },
    if: :fixed?


  scope :unshared, where('participations.owed != "even"')
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
    bill.participation_owed_total(self)
  end

  # What the person needs to pay back
  def debt
    owed_total - payment
  end

  # Calculation methods to show in a select box
  # for how much the person owes
  def self.owed_for_select
    {
      "even"  => "Even share",
      "zero"  => "Nothing",
      "all"   => "Everything",
      "percentage" => "A percentage",
      "fixed" => "Fixed amount",
    }.map { |k,v| [v,k] }
  end

end

