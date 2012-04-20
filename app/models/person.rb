class Person < ActiveRecord::Base
  def title
    name || email
  end
end

