require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  should belong_to(:bill)
  should belong_to(:person)

  should validate_presence_of(:owed)

  context "a participation from a bill" do
    setup {
      @user = Factory(:user)
      @bill = Factory(:bill, user: @user)
      @participation = Factory(:participation, payment: 21, person: @user, bill: @bill)
      @participation2 = Factory(:participation, payment: 42, bill: @bill)
    }

    context "owed zero" do
      setup { @participation.owed = "zero" }
      should "calculate owed total" do
        assert_equal 0, @participation.owed_total
      end
    end

    context "owed all" do
      setup { @participation.owed = "all" }
      should "calculate owed total" do
        assert_equal 21+42, @participation.owed_total
      end
    end

    context "owed percentage" do
      setup {
        @participation.owed = "percentage"
        @participation.owed_percent = 60
      }
      should "calculate owed total" do
        assert_equal (21+42)*0.60, @participation.owed_total
      end
    end

    context "owed fixed" do
      setup {
        @participation.owed = "fixed"
        @participation.owed_amount = 12
      }
      should "calculate owed total" do
        assert_equal 12, @participation.owed_total
      end
    end

    context "owed even" do
      setup {
        @participation.owed = "even"
        @participation2.owed = "even"
        @participation.save
        @participation2.save
      }
      should "calculate owed total" do
        assert_equal (21+42)/2.0, @bill.even_share
        assert_equal (21+42)/2.0, @participation.owed_total
      end
    end
  end
end

