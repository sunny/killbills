class User < Person
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :bills, dependent: :destroy
  has_many :friends, dependent: :destroy

  def me_and_my_friends
    [self, friends.order(:name)].flatten
  end

  def name
    "You"
  end
end

