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
    # TODO use a memoize-like class method to add this cache
    Rails.cache.fetch("#{cache_key}/debt") do
      bills.to_a.sum { |bill| bill.debt_for(id) }
    end
  end

  private

    def destroy_bills
      bills.destroy_all
    end
end

