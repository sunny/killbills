require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "be valid" do
    assert FactoryGirl.create(:user).valid?
  end

  should "be You" do
    assert_equal "You", FactoryGirl.build(:user, :name => "Joe").name
  end
end

