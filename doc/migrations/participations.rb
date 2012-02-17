Pull in the database from heroku:

    rake db:drop db:create
    heroku db:pull --confirm fricout
    rake db:migrate

After migration create participations, if the model is still in the previous version :

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

      bill.participations = [
        Participation.new(
          :person => bill.user,
          :payement => bill.user_payed,
          :owed => user_owed,
          :owed_percent => user_percent
        ),
        Participation.new(
          :person => bill.friend,
          :payement => bill.friend_payed,
          :owed => friend_owed,
          :owed_percent => friend_percent
        )
      ]
      bill.save!
    end

