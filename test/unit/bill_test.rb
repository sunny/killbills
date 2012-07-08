require 'test_helper'

class BillTest < ActiveSupport::TestCase

  should "be valid" do
    assert FactoryGirl.build(:bill).valid?
  end

  should "generate #title where friend pays" do
    bill = FactoryGirl.create :bill, :with_debt_user_to_friend
    assert_equal "Debt from Friend", bill.title
  end

  should "generate #title where user pays" do
    bill = FactoryGirl.create :bill, :with_debt_friend_to_user
    assert_equal "Debt to Friend", bill.title
  end

  should "generate #title where user and friend pay" do
    bill = FactoryGirl.create :bill, :with_debt_friend_and_user
    assert_equal "Debt with Friend", bill.title
  end

  should "generate #title with several friends" do
    bill = FactoryGirl.create :bill, :with_debt_three_friends_and_user
    assert_equal "Debt with Friend, Friend, and Friend", bill.title
  end

  should "accept a title" do
    bill = FactoryGirl.build :bill, title: "New title"
    assert_equal "New title", bill.title
  end

  should "calculate #total" do
    bill = FactoryGirl.create :bill
    FactoryGirl.create :participation, bill: bill, payment: 40
    FactoryGirl.create :participation, bill: bill, payment: 2
    assert_equal 42, bill.total
  end

  should "calculate #even_share" do
    bill = FactoryGirl.create :bill
    FactoryGirl.create :participation, :even, bill: bill, payment: 40
    FactoryGirl.create :participation, :even, bill: bill, payment:  2
    assert_equal (40+2)/2.0, bill.even_share
  end

  context "A bill with a debt" do
    setup {
      @beatrix = FactoryGirl.create :user
      @vernita = FactoryGirl.create :friend

      @bill = FactoryGirl.create :bill, user: @beatrix
      FactoryGirl.create :participation, :even, bill: @bill, person: @beatrix, payment: 2
      FactoryGirl.create :participation, :even, bill: @bill, person: @vernita, payment: 8

      # Total : 2+8 = 10
      # Even share : 10/2 = 5
      # Beatrix needs : 2-5 = -3
      # Oren needs :    8-5 = +3
    }

    should "return #debts" do
      assert_equal 1, @bill.debts.size
      assert_equal @beatrix, @bill.debts.first.from
      assert_equal @vernita, @bill.debts.first.to
      assert_equal 3.0,  @bill.debts.first.amount
    end

    should "return only user's diff in #user_diff" do
      # Should be Beatrix's debt
      assert_equal 3.0, @bill.user_diff
    end
  end

end

