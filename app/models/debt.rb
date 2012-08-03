# A Debt represents what a person owes to someone else.
# For example, that your friend Hattori owes you 5 € after
#
# Debts can be generated from bill participations.
class Debt
  include KillBillsHelper

  attr_accessor :from, :to, :amount

  def initialize(from, to, amount)
    raise ArgumentError.new("from cannot not be nil") if from.nil?
    raise ArgumentError.new("to cannot be nil") if to.nil?
    @from = from
    @to = to
    @amount = amount.to_f.round(2)
  end

  def inspect
    "<Debt #{currencize(amount)} #{from.name} to #{to.name}>"
  end

  def diff_for(person_id)
    if from == person_id
      amount
    elsif to == person_id
      -amount
    else
      0
    end
  end
end

