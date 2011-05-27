require 'test_helper'

class BillTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  should validate_presence_of(:friend_id)
  should validate_presence_of(:user_ratio)
  should validate_presence_of(:amount)
  should validate_presence_of(:user_payed)
  should validate_presence_of(:friend_payed)

  should_not allow_value("-1").for(:amount)
  should_not allow_value("-1").for(:user_ratio)
  should_not allow_value("2").for(:user_ratio)

  context "A new Bill" do
    should "have a default value for ratio" do
      assert_equal 1, Bill.new.user_ratio
    end
  end

  context "A Bill" do
    setup do
      @bill = bills(:coffee)
    end

    should "be valid" do
      assert @bill.valid?
    end
    
    should "have a friend and a user" do
      assert @bill.friend.is_a? Friend
      assert @bill.user.is_a? User
    end
  end
end
