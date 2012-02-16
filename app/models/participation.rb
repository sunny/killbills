class Participation < ActiveRecord::Base
  belongs_to :bill
  belongs_to :person

  scope :evens, where(owed: "even")

  def ratio
    case owed
      when :zero       then 0
      when :all        then 1
      when :percentage then owed_percent / 100
      when :fixed      then nil
      when :even       then bill.total / bill.participations.evens.count
    end
  end
end

