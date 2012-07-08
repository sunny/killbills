class Friend < Person
  # Associations
  belongs_to :user
  has_many :participations, foreign_key: :person_id

  # Hooks
  before_destroy :destroy_bills

  # Validations
  validates :name, presence: true

  def display_name
    name
  end

  def debt
    participations.sum(:debt)
  end

  def bills
    Bill.joins(participations: :person).where(participations: { person_id: id })
  end

  private

    def destroy_bills
      bills.destroy_all
    end

end

