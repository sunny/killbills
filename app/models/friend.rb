class Friend < Person
  # Associations
  belongs_to :user
  has_many :participations, foreign_key: :person_id
  has_many :bills, through: :participations

  # Hooks
  before_destroy :destroy_bills

  # Validations
  validates :name, presence: true

  def debt
    # FIXME should not need user.cache_key, but a participation should "touch"
    #       all friends from the same bill whenever modified.
    Rails.cache.fetch("#{user.cache_key}/#{cache_key}/debt") do
      bills.to_a.sum { |bill| bill.debt_for(id) }
    end
  end

  private

    def destroy_bills
      bills.destroy_all
    end
end

