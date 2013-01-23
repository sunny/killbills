require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "be valid" do
    assert build(:user).valid?
  end

  should "#display_name be name or email" do
    assert_equal "Beatrix", build(:user, :name => "Beatrix").display_name
    assert_equal "beatrix@kiddo.org", build(:user, :name => nil, :email => "beatrix@kiddo.org").display_name
  end

  should "destroy everything" do
    user = create :user
    friend = create :friend, user: user
    bill = create :bill, user: user
    participation = create :participation, bill: bill

    user.destroy

    assert Friend.where(id: friend).empty?
    assert Bill.where(id: bill).empty?
    assert Participation.where(id: participation).empty?
  end
end

