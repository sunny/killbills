class Participation < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person

  validates :owed,
    :presence => true,
    :inclusion => [:zero, :all, :percentage, :fixed, :even]

  scope :unshared, where('participations.owed != "even"')
  scope :shared, where(owed: "even")

  scope :friends, includes(:person).where(people: { type: 'Friend' })
  scope :users,   includes(:person).where(people: { type: 'User' })

  def owed_total
    case owed.to_sym
      when :zero       then return 0
      when :all        then return bill.total
      when :percentage then return bill.total * owed_percent / 100
      when :fixed      then return owed_amount.to_f
      when :even       then return bill.even_share
    end
  end

  def debt
    owed_total - payment
  end
end

