class Friend < Person
  # Associations
  belongs_to :user
  has_many :participations, foreign_key: :person_id

  # Hooks
  before_destroy :destroy_bills

  # Validations
  validates :name, presence: true

  def debt
    Rails.cache.fetch("#{cache_key}/debt") do
      # FIXME Holy shmoly requests n+galore
      bills.to_a.sum { |bill|
        bill.debts.sum { |debt|
          debt.diff_for(self)
        }
      }
    end
  end

  def bills
    Bill.joins(participations: :person).where(participations: { person_id: id })
  end

  private

    def destroy_bills
      bills.destroy_all
    end

end

