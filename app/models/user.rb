class User < Person
  # Associations
  has_many :bills, dependent: :destroy
  has_many :friends, dependent: :destroy

  # Attributes
  devise :database_authenticatable, :registerable

  # Scopes
  scope :users, -> { where(type: "User") }

  def me_and_my_friends
    [self, friends.order(:name)].flatten
  end

  def bills_with_friend(friend)
    bills.joins(:participations) \
      .includes(participations: :person) \
      .where(participations: { person_id: friend.id }) \
      .order("date DESC")
  end

  def display_name
    email
  end
end
