require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  should "be valid" do
    assert build(:friend).valid?
  end

  should "return name as #display_name" do
    assert_equal "Gogo", build(:friend, name: "Gogo").display_name
  end

  should "destroy bills" do
    user = create :user
    friend = create :friend, user: user
    bill = create :bill, user: user
    participation = create :participation, person: friend, bill: bill

    friend.destroy

    assert Participation.where(id: participation).empty?
    assert Bill.where(id: bill).empty?
  end

  context "A friend with debts" do
    setup {
      @bill = create :bill
      @friend = create :friend
      @user = create :user
      create :participation, :getting, bill: @bill, person: @friend
      create :participation, :paying,  bill: @bill, person: @user
    }

    should "calculate #debt" do
      assert_equal 42, @friend.debt
    end


    should "return #bills" do
      assert_equal @friend.bills, [@bill]
    end
  end
end

