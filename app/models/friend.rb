class Friend < Person
  belongs_to :user

  validates :name, :presence => true

  def debt
    participations.sum(:debt)
  end

  def user_debt
    debt > 0 ? debt : 0
  end

  def friend_debt
    debt < 0 ? debt.abs : 0
  end

end

