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

  def diff_for(person)
    if from == person
      amount
    elsif to == person
      -amount
    else
      0
    end
  end
end

