# A Debt represents what a person owes to someone else.
# For example, that your friend Hattori owes you 5 €
class Debt
  include Draper::Decoratable

  # TODO rename:
  #   from -> from_id
  #   from_person -> from
  #   to -> to_id
  #   to_person -> to

  attr_accessor :from, :to, :amount

  def initialize(from, to, amount)
    raise ArgumentError.new("from cannot not be nil") if from.nil?
    raise ArgumentError.new("to cannot be nil") if to.nil?
    @from = from
    @to = to
    @amount = amount.to_f.round(2)
  end

  def inspect
    "<Debt #{amount} #{from_person.name} to #{to_person.name}>"
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

  def from_person
    from.kind_of?(Person) ? from : Person.find(from)
  end

  def to_person
    to.kind_of?(Person) ? to : Person.find(to)
  end
end

