require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  should belong_to(:bill)
  should belong_to(:person)
end

