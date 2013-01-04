class User < Person
  # Associations
  has_many :bills, dependent: :destroy
  has_many :friends, dependent: :destroy

  # Attributes
  include Enumerize
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  enumerize :currency, in: %w(USD EUR), default: 'USD'
  attr_accessible :currency, :email, :password, :password_confirmation, :remember_me

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
end
