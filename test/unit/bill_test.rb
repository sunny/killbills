require 'test_helper'

class BillTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:participations)

  should validate_presence_of(:date)

  context "A Bill" do
    setup do
      @bill = Factory(:bill)
      Factory(:user_giver_participation, :bill => @bill)
      Factory(:friend_getter_participation, :bill => @bill)
    end

    should "be valid" do
      assert @bill.valid?
    end

    should "have an automatic title" do
      assert_equal "Coffee", @bill.automatic_title
      @bill.title = ""
      assert_equal "$42.00 with Friend", @bill.automatic_title
    end

    should "calculate total" do
      assert_equal 42, @bill.total
    end

    should "calculate even_share" do
      #assert_equal -42, @bill.user_debt
    end
  end

end

