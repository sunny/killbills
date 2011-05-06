class Friend < Person
  belongs_to :user
  has_many :bills

  validates :name, :presence => true

  def debt
    @debt ||= bills.sum('user_ratio * amount - user_payed').to_f
  end

  def user_debt
    debt > 0 ? debt : 0
  end
  
  def friend_debt
    debt < 0 ? debt.abs : 0
  end
  
end
