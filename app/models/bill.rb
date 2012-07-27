include ApplicationHelper

class Bill < ActiveRecord::Base
  include KillBillsHelper
  include Enumerize

  # Associations
  belongs_to :user
  has_many :participations, dependent: :destroy

  # Attributes
  enumerize :genre, in: [:debt, :payment, :shared], default: :debt
  attr_accessible :title, :date, :genre, :participations_attributes
  accepts_nested_attributes_for :participations

  # Hooks
  before_validation :assign_default_date

  # Validations
  validates :date, presence: true
  validates :user, presence: true
  # validates_associated :participations
  # validate :ensure_user_is_in_bill
  # validate :ensure_payments
  # validate :ensure_payments_add_up
  # validate :ensure_creates_debt


  # Title based on the participations
  #
  # Examples:
  # - "Payment from O-Ren"
  # - "Payment with Budd"
  # - "Payment to Beatrix"
  # - "Debt from Pai-Mei"
  # - "Debt with B.B."
  # - "Debt to Bill"
  # - "Shared to Vernita and Nikki"
  def automatic_title
    friend_names = participations.friends.map{ |p| p.person.name }.sort

    if genre.debt?
      direction = debts.first.to == user ? "from" : "to"
    elsif genre.payment?
      direction = debts.first.to == user ? "to" : "from"
    else
      direction = "with"
    end

    "#{genre.text} #{direction} #{friend_names.to_sentence}"
  end

def test
@bill = Bill.last
friend_names = @bill.participations.friends.map{ |p| p.person.name }.sort
if @bill.genre.shared?
  direction = "with"
else
  direction = @bill.debts.first.to == @bill.user ? "from" : "to"
end
"#{@bill.genre.text} #{direction} #{friend_names.to_sentence}"
@bill.automatic_title
end


  # Fallback to automatic_title
  def title
    super.blank? ? automatic_title : super
  end

  #### Participations

  # Total payments
  def total
    participations.sum(:payment)
  end

  # Calculate what a share is worth
  def even_share
    shared, unshared = participations.all.partition(&:shared?)

    # No even share if nobody shares
    return 0 if shared.empty?

    total = self.total
    # deduce fixed amounts if any
    total -= unshared.map(&:owed_total).sum
    total / shared.size
  end


  #### Debts

  def debts

    # Debt
    if genre.debt?
      min_ower, max_ower = participations.all.sort_by { |p| p.owed_amount.to_f }
      debt = max_ower.owed_amount.to_f - min_ower.owed_amount.to_f
      return [Debt.new(max_ower.person, min_ower.person, debt)]
    end

    # Payment
    if genre.payment?
      min_payer, max_payer = self.participations.all.sort_by { |p| p.payment.to_f }
      debt = max_payer.payment.to_f - min_payer.payment.to_f
      return [Debt.new(min_payer.person, max_payer.person, debt)]
    end

    # Shared

    # Create a hash of participation diffs
    # Example: {<Person1> => -5, <Person2> => 5}
    diffs = {}

    participations.map { |participation|
      owed = case participation.owed_type
        when "even"       then even_share
        when "zero"       then 0
        when "all"        then total
        when "percentage" then total * participation.owed_percent.to_f / 100
        when "fixed"      then participation.owed_amount
        else 0
      end

      owed = owed.to_f - participation.payment.to_f

      diffs[participation.person] = owed if owed
    }


    debts = []

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

  #def user_diff
  #  -debts.sum { |debt| debt.diff_for(user) }
  #end

  # Debt against the bill creator
  def user_debt
    participations.friends.sum(:debt)
  end



private

    # Commented hungry validations that most of the time don't work

    # def ensure_user_is_in_bill
    #   participations = participations.all
    #   unless participations.empty? or \
    #          participations.map(&:person).include?(user)

    #     errors_on_group(:participations, :person_id, participations,
    #       "must contain yourself")
    #   end
    # end

    # def ensure_payments
    #   participations = participations.all
    #   unless participations.empty? or total > 0
    #     errors_on_group(:participations, :payment, participations,
    #       "total must be greater than 0")
    #   end
    # end

    # def ensure_payments_add_up
    #   participations = participations.all
    #   unless participations.empty? or total.zero?
    #     participations_owed_total = participations.sum(&:owed_total)
    #     if participations_owed_total != total
    #       errors_on_group(:participations, :owed, participations,
    #         "must sum up to #{total} (now #{participations_owed_total})")
    #     end
    #   end
    # end

    # TODO Add this validation in order not to save bills with no debt
    # Does not work because it needs the bill to be saved
    # (because of accessing bill on participations)
    #def ensure_creates_debt
    #  unless participations.empty? or debts.size > 0
    #    errors_on_group(:participations, :owed, participations,
    #      "must create a debt")
    #  end
    #end

    def assign_default_date
      self.date ||= Time.now.to_date
    end
end

