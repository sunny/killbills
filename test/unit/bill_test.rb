require 'test_helper'

class BillTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  should validate_presence_of(:friend_id)
  should validate_presence_of(:user_ratio)
  should validate_presence_of(:amount)
  should validate_presence_of(:user_payed)
  should validate_presence_of(:friend_payed)

  should validate_numericality_of(:amount)
  should validate_numericality_of(:user_ratio)
  should validate_numericality_of(:user_payed)
  should validate_numericality_of(:friend_payed)

  should_not allow_value("-1").for(:amount)
  should_not allow_value("-1").for(:friend_payed)
  should_not allow_value("-1").for(:user_payed)
  should_not allow_value("-1").for(:user_ratio)
  should_not allow_value("2").for(:user_ratio)

  context "A Bill" do
    should "have a default value for user_ratio" do
      assert_equal 1, Bill.new.user_ratio
    end

    should "be valid" do
      @bill = Factory.build(:bill)
      assert @bill.valid?
      assert @bill.friend.is_a? Friend
      assert @bill.user.is_a? User
    end

    should "have an automatic title" do
      @bill = Factory.build(:bill, :title => "Coffee")
      assert_equal "Coffee", @bill.automatic_title
    end
    
    should "have an automatic title" do
      @bill = Factory.build(:bill, :title => "",
        :user_payed => 42, :friend_payed => 0, :amount => 42)
      assert_match /^You payed 42/, @bill.automatic_title
      @bill = Factory.build(:bill, :title => "",
        :user_payed => 40, :friend_payed => 2, :amount => 42)
      assert_match /^You and .* payed 42/, @bill.automatic_title
    end

    should "calculate the friend_ratio" do
      @bill = Factory.build(:bill, :user_ratio => 0.7)
      assert_equal 0.3, @bill.friend_ratio
    end

    should "calculate the user and friend debt" do
      @bill = Factory.build(:bill,
        :amount => 4,
        :user_ratio => 0.5,
        :user_payed => 1,
        :friend_payed => 3)
      assert_equal 1, @bill.user_debt
      assert_equal -1, @bill.friend_debt
    end

    should "ensure there is a debt" do
      @bill = Factory.build(:bill,
        :amount => 2,
        :user_ratio => 0.5,
        :user_payed => 1,
        :friend_payed => 1)
      assert !@bill.valid?
    end

    should "ensure people paid the total" do
      @bill = Factory.build(:bill,
        :amount => 3,
        :user_payed => 0,
        :friend_payed => 1)
      assert !@bill.valid?

      @bill.user_payed = 4
      assert !@bill.valid?

      @bill.user_payed = 2
      assert @bill.valid?
    end

  end

end
