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
    FactoryGirl.create :participation, bill: bill, payment: 40, owed: "even"
    FactoryGirl.create :participation, bill: bill, payment:  2, owed: "even"
    assert_equal (40+2)/2.0, bill.even_share
  end

end

