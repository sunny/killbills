require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "be valid" do
    assert FactoryGirl.build(:user).valid?
  end

  should "#display_name be You" do
    assert_equal "You", FactoryGirl.build(:user, :name => "Beatrix").display_name
  end
end

