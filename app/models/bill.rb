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
  validate :ensure_user_is_in_bill
  validate :ensure_payments
  validate :ensure_payments_add_up

  # Whole bill total
  # FIXME should use participations.sum(:payment) but it returns 0
  def total
    payments = participations.map { |p| p.payment || 0 }
    payments.sum.to_f
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
    unshared_amount = participations.unshared.sum(&:owed_total)
    left_for_share = total - unshared_amount
    shares = participations.shared.count
    left_for_share / shares
  end

private

  def ensure_user_is_in_bill
    unless participations.empty? or \
           participations.map(&:person).include?(user)

      errors[:"participations.person_id"] = "must contain yourself"
      participations.each { |p|
        p.errors[:person_id] = errors[:"participations.person_id"]
      }
    end
  end

  def ensure_payments
    unless participations.empty? or total > 0
      errors[:"participations.payment"] = "total must be greater than 0"
      participations.each { |p|
        p.errors[:payment] = errors[:"participations.payment"]
      }
    end
  end

  def ensure_payments_add_up
    unless participations.empty?
      sum = total
      debt_sum = participations.map(&:owed_total).sum
      if total >= 0 and sum != total
        errors[:"participations.owed"] = "must sum up to #{total} (now #{participations.map(&:debt).sum})"
        participations.each { |p|
          p.errors[:owed] = errors[:"participations.owed"]
        }
      end
    end
  end
end

