require 'test_helper'

class BillTest < ActiveSupport::TestCase
  # TODO should destroy participations

  should "genre should default to Debt" do
    assert Bill.new.genre.debt?
  end

  should "genre should be restricted to authorized values" do
    assert build(:bill, genre: :payment).valid?
    assert_false build(:bill, genre: :foo).valid?
  end

  context "A Payment Bill" do
    context "with a paying friend" do
      setup {
        @bill = create :bill, genre: :payment
        create(:participation, bill: @bill, payment: 42)
        create(:participation, bill: @bill, payment: 0, person: @bill.user)
      }
      should("generate #title") { assert_equal "Payment from Friend", @bill.title }
    end

    context "with a paying user" do
      setup {
        @bill = create :bill, genre: :payment
        create(:participation, bill: @bill, payment: 42, person: @bill.user)
        create(:participation, bill: @bill, payment: 0)
      }
      should("generate #title") { assert_equal "Payment to Friend", @bill.title }
    end
  end

  context "A Shared Bill" do
    setup { @bill = create :bill, :shared, :with_paying_user, :with_friend, :with_friend, :with_friend }
    should("generate #title") { assert_equal "Shared with Friend, Friend, and Friend", @bill.title }
  end

  should "accept a title" do
    bill = build :bill, title: "New title"
    assert_equal "New title", bill.title
  end

  should "calculate #total" do
    bill = create :bill
    create :participation, bill: bill, payment: 40
    create :participation, bill: bill, payment: 2
    assert_equal 42, bill.total
  end

  should "calculate #even_share" do
    bill = create :bill
    create :participation, :even, bill: bill, payment: 40
    create :participation, :even, bill: bill, payment:  2
    assert_equal (40+2)/2.0, bill.even_share
  end

  context "A payment bill" do
    setup {
      beatrix = create :user,   name: "Beatrix"
      vernita = create :friend, name: "Vernita"

      # Beatrix is smallest payer 2<8
      # Beatrix owes Vernita      8-2 = 6
      @bill = create :bill, genre: :payment, user: beatrix
      create :participation, bill: @bill, person: beatrix, payment: 2
      create :participation, bill: @bill, person: vernita, payment: 8
    }

    should "generate #title" do
      assert_equal "Payment from Vernita", @bill.title
    end

    should "return #debts" do
      debts = @bill.debts
      assert_equal 1,         debts.size
      assert_equal "Beatrix", debts[0].from_person.name
      assert_equal "Vernita", debts[0].to_person.name
      assert_equal 6,         debts[0].amount
    end
  end

  context "A debt bill" do
    setup {
      bb     = create :user,   name: "B.B."
      paimei = create :friend, name: "Pai-Mei"

      # B.B. is biggest ower 4>2
      # B.B. owes Pai-Mei    4-2 = 2
      @bill = create :bill, :debt, user: bb
      create :participation, bill: @bill, person: bb,     owed_amount: 4
      create :participation, bill: @bill, person: paimei, owed_amount: 2
    }

    should "generate #title" do
      assert_equal "Debt to Pai-Mei", @bill.title
    end

    should "return #debts" do
      debts = @bill.debts
      assert_equal 1,         debts.size
      assert_equal "B.B.",    debts[0].from_person.name
      assert_equal "Pai-Mei", debts[0].to_person.name
      assert_equal 2,         debts[0].amount
    end
  end

  context "A shared bill with three participations" do
    setup {
      bb =      create :user,   name: "B.B."
      sofie =   create :friend, name: "Sofie"
      hattori = create :friend, name: "Hattori"

      # Total               100+0+0 = 100
      # Even share            100/3 = 33.33333333
      # Sofie needs   100-33.333333 = 66.6666666
      # Hattori needs   0-33.333333 = -33.333333
      # B.B. needs      0-33.333333 = -33.333333
      # Hattori owes Sofie            33.33
      # B.B. owes Sofie               33.33
      @bill = create :bill, :shared, user: bb
      create :participation, :even, bill: @bill, payment: 0,   person: bb
      create :participation, :even, bill: @bill, payment: 100, person: sofie
      create :participation, :even, bill: @bill, payment: 0,   person: hattori
    }

    should "generate #title" do
      assert_equal "Shared with Hattori and Sofie", @bill.title
    end

    should "return #debts" do
      debts = @bill.debts.sort_by { |d| d.from_person.name } # Sorted for our asserts

      assert_equal 2, debts.size

      assert_equal "B.B.",    debts[0].from_person.name
      assert_equal "Sofie",   debts[0].to_person.name
      assert_equal 33.33,     debts[0].amount

      assert_equal "Hattori", debts[1].from_person.name
      assert_equal "Sofie",   debts[1].to_person.name
      assert_equal 33.33,     debts[1].amount
    end
  end
end

