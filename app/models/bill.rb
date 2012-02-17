include ApplicationHelper

class Bill < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :title, :date

  belongs_to :user
  has_many :participations

  # Validations

  validates_presence_of :date

  # Whole bill total
  # FIXME should use participations.sum(:payment) but it returns 0
  def total
    participations.to_a.sum(&:payment).to_f
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
end

