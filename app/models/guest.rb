class Guest < User

  # Override devise's validator on email
  def update_attributes(*attributes)
    update = super(*attributes)
    if update
      true
    elsif errors.size == 1 and errors[:email]
      save(validate: false)
    else
      false
    end
  end

  def display_name
    "Anonymous Guest"
  end

  # Create without user validations
  def self.create(*params)
    Guest.new.tap { |g| g.save!(validate: false) }
  end
end
