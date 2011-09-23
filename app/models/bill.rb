include ApplicationHelper

class Bill < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :title, :amount, :date, :friend_id, :user_payed,
    :friend_payed, :user_ratio

  belongs_to :user
  belongs_to :friend

  after_initialize :assign_default_values

  # Validations

  validates_presence_of :date, :friend_id, :user_ratio,
    :amount, :user_payed, :friend_payed
  validates_associated :friend

  validates_numericality_of :user_ratio,
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 1

  validates_numericality_of :amount,
    :greater_than_or_equal_to => 0
  validates_numericality_of :user_payed, :friend_payed,
    :greater_than_or_equal_to => 0
  validates_numericality_of :user_payed, :friend_payed,
    :less_than_or_equal_to => lambda { |b| b.amount },
    :unless => 'amount.blank?'

  validate :amounts_must_add_up
  validate :creates_a_debt

  def user_debt
    user_ratio * amount - user_payed
  end

  def friend_debt
    friend_ratio * amount - friend_payed
  end

  def friend_ratio
    1 - user_ratio
  end

  def automatic_title
    return title unless title.blank?
    who_payed = []
    who_payed << "You" if user_payed > 0
    who_payed << friend.name if friend_payed > 0
    "#{who_payed.to_sentence} payed #{number_to_currency amount}"
  end

  def assign_default_values
    self.user_ratio ||= 1
  end


  private

  def amounts_must_add_up
    errors.add(:friend_payed, "must add up to the amount payed") if
      amount != user_payed.to_f + friend_payed.to_f
  end

  def creates_a_debt
    errors[:base] << "A bill should result in a debt" if
      !user_payed.nil? and !friend_payed.nil? and \
      user_debt == 0 and friend_debt == 0
  end
end

