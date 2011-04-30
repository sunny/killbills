class Bill < ActiveRecord::Base
  attr_accessible :title, :amount, :date, :friend_id, :user_payed, :friend_payed, :user_ratio

  belongs_to :user
  belongs_to :friend


  # Validations

  validates_presence_of :title, :date, :friend_id, :user_ratio,
    :amount, :user_payed, :friend_payed
  validates_associated :friend

  validates_numericality_of :user_ratio,
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 1

  validates_numericality_of :amount,
    :greater_than_or_equal_to => 0
  validates_numericality_of :user_payed, :friend_payed,
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => lambda { |b| b.amount },
    :unless => 'amount.blank?'
  validate :amounts_must_add_up

  after_initialize :default_values

  def user_debt
    friend_ratio * amount - user_payed
  end
  
  def friend_debt
    user_ratio * amount - friend_payed
  end
  
  def friend_ratio
    1 - user_ratio
  end

  private
  def amounts_must_add_up
    errors.add(:friend_payed, "must add up to the amount payed") if
      amount != user_payed.to_f + friend_payed.to_f
  end

  def default_values
    self.user_ratio ||= 1
  end
end
