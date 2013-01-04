class Guest < User
  def display_name
    "Anonymous Guest"
  end

  # Create without user validations
  def self.create(*params)
    Guest.new.tap { |g| g.save!(validate: false) }
  end
end
