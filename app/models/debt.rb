class Debt
  attr_accessor :from, :to, :amount

  def initialize(from, to, amount)
    @from = from
    @to = to
    @amount = amount
  end

  def inspect(full = false)
    return super() if full
    "<Debt $#{amount} #{from.name} to #{to.name}>"
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
    # Example: {<Person> => -5, <Person> => 5}
    diffs = {}
    bill.participations.each { |p|
      diffs[p.person] = p.debt
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

        # Lessen the respective diffs for next calculations
        diffs[poorest] -= amount
        diffs[person] -= amount
      end
    end

    debts

  end
end

