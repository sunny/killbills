include ApplicationHelper

class Bill < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :title, :date

  belongs_to :user
  has_many :participations

  # Validations

  validates_presence_of :date


  # DEPRECATED
  def amount
    participations.sum(:payment)
  end

  # DEPRECATED
  def user_payed
    participations.where(person_id: user_id).first.try(:payment).to_i
  end

  # DEPRECATED
  def user_debt
    user_ratio * amount - user_payed
  end

  # DEPRECATED
  def user_ratio
    participations.where(person_id: user_id).first.try(:ratio).to_i
  end



  # DEPRECATED
  def friend
    participations.where("person_id != ?", user_id).first.try(:person)
  end

  # DEPRECATED
  def friend_payed
    participations.where("person_id != ?", user_id).first.try(:payment)
  end

  # DEPRECATED
  def friend_debt
    friend_ratio * amount - friend_payed
  end

  # DEPRECATED
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


  private


end

