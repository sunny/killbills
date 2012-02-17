class Participation < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person

  validates :owed,
    :presence => true,
    :inclusion => { in: %w(even zero all percentage fixed) }

  scope :unshared, where('participations.owed != "even"')
  scope :shared, where(owed: "even")

  scope :friends, includes(:person).where(people: { type: 'Friend' })
  scope :users,   includes(:person).where(people: { type: 'User' })

  def owed_total
    case owed
      when "even"       then bill.even_share
      when "zero"       then 0
      when "all"        then bill.total
      when "percentage" then bill.total * owed_percent / 100
      when "fixed"      then owed_amount.to_f
      else
        owed
    end
  end

  def debt
    owed_total - payment
  end

  def self.owed_types
    {
      "even"  => "Even share",
      "zero"  => "Nothing",
      "all"   => "Everything",
      "percentage" => "A percentage",
      "fixed" => "Fixed amount",
    }
  end

  def self.owed_for_select
    self.owed_types.map { |k,v| [v,k] }
  end
end

