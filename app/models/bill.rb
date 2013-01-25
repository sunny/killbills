class Bill < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :people, through: :participations

  # Attributes
  include ActiveModel::ForbiddenAttributesProtection
  include Enumerize
  enumerize :genre, in: [:debt, :payment, :shared], default: :debt
  accepts_nested_attributes_for :participations

  # Hooks
  before_validation :assign_default_date
  after_touch :touch_people

  # Validations
  validates :date, presence: true
  validates :user, presence: true
  # validates_associated :participations
  # validate :ensure_user_is_in_bill
  # validate :ensure_payments
  # validate :ensure_payments_add_up
  # validate :ensure_creates_debt

  #### Participations

  # Total payments
  def total
    participations.to_a.sum{ |p| p.payment.to_f }
  end

  # Calculate what a share is worth
  def even_share
    shared, unshared = participations.to_a.partition(&:shared?)

    # No even share if nobody shares
    return 0 if shared.empty?

    total = self.total
    # deduce fixed amounts if any
    total -= unshared.map(&:owed_total).sum
    total / shared.size
  end


  #### Debts

  def debts

    participations = self.participations.to_a

    return [] if participations.empty? or participations.size == 1

    # Debt
    if genre.debt?
      min_ower, max_ower = participations.sort_by { |p| p.owed_amount.to_f }
      debt = max_ower.owed_amount.to_f - min_ower.owed_amount.to_f
      return [Debt.new(max_ower.person_id, min_ower.person_id, debt)]
    end

    # Payment
    if genre.payment?
      min_payer, max_payer = participations.sort_by { |p| p.payment.to_f }
      debt = max_payer.payment.to_f - min_payer.payment.to_f
      return [Debt.new(min_payer.person_id, max_payer.person_id, debt)]
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

      diffs[participation.person_id] = owed if owed
    }


    debts = []

    # For each participant
    diffs.each do |person_id, |

      # If that person (still) has a debt
      while diffs[person_id] > 0

        # Person who should get payed the most
        poorest_id, = diffs.min_by { |k,v| v }

        # Amount that can be transferred
        amount = [diffs[poorest_id].abs, diffs[person_id]].min

        # Create a debt
        debts << Debt.new(person_id, poorest_id, amount)

        # Lessen the respective diffs for next turn
        diffs[poorest_id] -= amount
        diffs[person_id] -= amount
      end
    end

    debts
  end

  def debt_for(id)
    debts.sum { |debt| debt.diff_for(id) }
  end

  def debt
    debts.first
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

    def touch_people
      people.touch_all
    end
end

