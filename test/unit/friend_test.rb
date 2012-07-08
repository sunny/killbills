require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  should "be valid" do
    assert FactoryGirl.build(:friend).valid?
  end

  should "return name as #display_name" do
    assert_equal "Gogo", FactoryGirl.build(:friend, :name => "Gogo").display_name
  end

  context "A friend with debts" do
    setup {
      @bill = FactoryGirl.create :bill
      @friend = FactoryGirl.create :friend
      @user = FactoryGirl.create :user
      FactoryGirl.create :participation, :getting, bill: @bill, person: @friend
      FactoryGirl.create :participation, :paying,  bill: @bill, person: @user
    }

    should "calculate #debt" do
      assert_equal 42, @friend.debt
    end


    should "return #bills" do
      assert_equal @friend.bills, [@bill]
    end
  end
end

