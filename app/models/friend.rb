class Friend < Person
  belongs_to :user
  has_many :participations, foreign_key: :person_id

  validates :name, presence: true

  before_destroy :destroy_bills


  def debt
    participations.sum(:debt)
  end

private

  def destroy_bills
    user.bills_with_friend(self).destroy_all
    participations.destroy_all
  end

end

