include ApplicationHelper

class Bill < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :participations, :dependent => :destroy

  attr_accessible :title, :date, :participations_attributes
  accepts_nested_attributes_for :participations

  # Validations

  validates :date, :presence => true
  validates :user, :presence => true
  validates_associated :participations

  validate :ensure_user_is_in_bill
  validate :ensure_payments
  validate :ensure_payments_add_up
  #validate :ensure_creates_debt

  # Whole bill total
  def total
    # (should use participations.sum(:payment) but it returns 0)
    payments = participations.map { |p| p.payment || 0 }
    payments.sum.to_f
  end

  def debts
    Debt.from_bill(self)
  end

  def user_diff
    debts.sum { |debt| debt.diff_for(user) }
  end

  # Title based on the participations
  def automatic_title
    return title unless title.blank?
    friend_names = participations.friends.map{ |p| p.person.name }
    "#{number_to_currency total} with #{friend_names.join(', ')}"
  end

  # Debt against the bill creator
  def user_debt
    participations.friends.sum(:debt)
  end

  # Calculate what a share is worth
  def even_share
    shared, unshared = participations.partition(&:shared?)

    # No even share if nobody shares
    return 0 unless shared

    total = self.total

    # If there are any fixed amounts, deduce them
    total -= participations_owed_total(unshared) if unshared

    total / shared.size
  end


  def participation_owed_total(participation)
    case participation.owed
      when "even"       then even_share
      when "zero"       then 0
      when "all"        then total
      when "percentage" then total * participation.owed_percent.to_f / 100
      when "fixed"      then participation.owed_amount
      else
        participation.owed
    end.to_f
  end

  def participations_owed_total(participations = nil)
    participations ||= self.participations
    participations.to_a.sum { |p| participation_owed_total(p) }
  end


private

  def ensure_user_is_in_bill
    unless participations.empty? or \
           participations.map(&:person).include?(user)

      errors_on_group(:participations, :person_id, participations, 
        "must contain yourself")
    end
  end

  

  def ensure_payments
    unless participations.empty? or total > 0
      errors_on_group(:participations, :payment, participations,
        "total must be greater than 0")
    end
  end

  def ensure_payments_add_up
    unless participations.empty? or total.zero?
      if participations_owed_total != total
        errors_on_group(:participations, :owed, participations,
          "must sum up to #{total} (now #{participations_owed_total})")
      end
    end
  end

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
end

