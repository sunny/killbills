require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:bills)
  should have_many(:friends)
end
