require 'test_helper'

class BillTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:participations)

  should validate_presence_of(:date)

  context "A Bill" do
    setup do
      @you = Factory.build(:user)
      @friend = Factory.build(:friend)
    end

    should "be valid" do
      @bill = Factory.build(:bill)
      assert @bill.valid?
    end

    should "have an automatic title" do
      @bill = Factory.build(:bill, :title => "Coffee")
      assert_equal "Coffee", @bill.automatic_title

      @bill = Factory(:bill, :participations => [
          Factory(:user_participation, :payment => 42, :owed => :zero),
          Factory(:friend_participation, :payment => 0, :owed => :all)
        ]
      )
      assert_equal "You payed $42.00", @bill.automatic_title

      @bill = Factory.build(:bill, :title => "",
        :user_payed => 40, :friend_payed => 2, :amount => 42)
      assert_match /^You and .* payed \$42.00$/, @bill.automatic_title
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



  end

end

