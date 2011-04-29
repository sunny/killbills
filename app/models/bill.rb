class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  
  def debt
    (amount * user_ratio) - user_payed
  end
end
