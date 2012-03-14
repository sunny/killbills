class UseParticipations < ActiveRecord::Migration
  def up
    Bill.all.each do |bill|

      if bill.user_ratio == 0
        user_owed = "zero"
        friend_owed = "all"
        user_percent = nil
        friend_percent = nil
      elsif bill.user_ratio == 1
        user_owed = "all"
        friend_owed = "zero"
        user_percent = nil
        friend_percent = nil
      else
        user_owed = "percent"
        friend_owed = "percent"
        user_percent = bill.user_ratio * 100
        friend_percent = 100 - user_percent
      end

      Participation.create(
        :person_id => bill.user_id,
        :payment => bill.user_payed,
        :owed => user_owed,
        :owed_percent => user_percent,
        :bill_id => bill.id,
        :created_at => bill.created_at
      )

      Participation.create(
        :person_id => bill.friend_id,
        :payment => bill.friend_payed,
        :owed => friend_owed,
        :owed_percent => friend_percent,
        :bill_id => bill.id,
        :created_at => bill.created_at
      )
    end
  end

  def down
    Participation.delete_all
  end
end
