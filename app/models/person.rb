class Person < ActiveRecord::Base
  def display_name
    name || email
  end
end

