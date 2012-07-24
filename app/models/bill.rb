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
  validates_associated :participations
  # validate :ensure_user_is_in_bill
  # validate :ensure_payments
  # validate :ensure_payments_add_up
  # validate :ensure_creates_debt


  # Title based on the participations
  # Examples:
  #   "Debt from O-Ren" if O-Ren payed
  #   "Debt to Beatrix" if you payed
  #   "Debt with Budd" if both payed
  #   "Debt to Vernita and Nikki" if you payed
  def automatic_title
    friend_names = participations.friends.map{ |p| p.person.name }
    user_payed = participations.users.sum(:payment) > 0
    friend_payed = participations.friends.sum(:payment) > 0
    direction = case
      when user_payed && friend_payed then "with"
      when user_payed then "from"
      when friend_payed then "to"
    end
    "Debt #{direction} #{friend_names.to_sentence}"
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
    Debt.from_bill(self)
  end

  def user_diff
    debts.sum { |debt| debt.diff_for(user) }
  end

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

    # Helper to add errors on children
    def errors_on_group(group, attribute, children, message = "")
      errors[:"#{group}.#{attribute}"] = message
      children.each { |child| child.errors[attribute] = message }
    end

    def assign_default_date
      self.date ||= Time.now.to_date
    end
end

