require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "be valid" do
    assert FactoryGirl.build(:user).valid?
  end

  should "#display_name be name or email" do
    assert_equal "Beatrix", FactoryGirl.build(:user, :name => "Beatrix").display_name
    assert_equal "beatrix@kiddo.org", FactoryGirl.build(:user, :name => nil, :email => "beatrix@kiddo.org").display_name
  end
end

