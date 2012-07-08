class Debt
  include FricoutHelper # for currencize

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

  def self.from_bill(bill)
    debts = []

    # Create a hash of participation diffs
    # Example: {<Person1> => -5, <Person2> => 5}
    diffs = {}
    bill.participations.all.each { |participation|
      diffs[participation.person] = participation.debt
    }

    # For each participant
    diffs.each do |person, |

      # If that person (still) has a debt
      while diffs[person] > 0

        # Person who should get payed the most
        poorest, = diffs.min_by { |k,v| v }

        # Amount that can be transferred
        amount = [diffs[poorest].abs, diffs[person]].min

        # Create a debt
        debts << Debt.new(person, poorest, amount)

        # Lessen the respective diffs for next turn
        diffs[poorest] -= amount
        diffs[person] -= amount
      end
    end

    debts
  end
end

