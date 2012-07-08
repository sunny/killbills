require 'test_helper'

class DebtTest < ActiveSupport::TestCase
  context "A debt" do
    setup {
      @oren = FactoryGirl.build :friend, name: "O-Ren"
      @elle = FactoryGirl.build :friend, name: "Elle"
      @debt = Debt.new(@oren, @elle, 42) # from, to, amount
    }

    should "#from #to #amount #inspect" do
      assert_equal "O-Ren", @debt.from.name
      assert_equal "Elle", @debt.to.name
      assert_equal 42, @debt.amount
      assert_equal "<Debt $42 O-Ren to Elle>", @debt.inspect
    end

    should "#diff_for" do
      assert_equal +42, @debt.diff_for(@oren)
      assert_equal -42, @debt.diff_for(@elle)
      assert_equal   0, @debt.diff_for(FactoryGirl.build(:friend))
    end
  end

  should "extract debts #from_bill with one debt" do
    bill = FactoryGirl.create :bill
    budd = FactoryGirl.create :friend, name: "Budd"
    beatrix = FactoryGirl.create :user, name: "Beatrix"
    FactoryGirl.create :participation, :even, bill: bill, person: beatrix, payment: 8
    FactoryGirl.create :participation, :even, bill: bill, person: budd, payment: 2
    debts = Debt.from_bill(bill)

    # Total = 8+2 = 10
    # Even share = 10/2 = 5
    # Beatrix needs = 8-5 = 3
    # Budd needs    = 2-5 = -3
    assert_equal 1, debts.size

    assert_equal "Budd",    debts[0].from.name
    assert_equal "Beatrix", debts[0].to.name
    assert_equal 3,         debts[0].amount
  end

  should "extract debts #from_bill with two debts" do
    bill = FactoryGirl.create :bill
    sofie = FactoryGirl.create :friend, name: "Sofie"
    hattori = FactoryGirl.create :user, name: "Hattori"
    bb = FactoryGirl.create :user, name: "B.B."
    FactoryGirl.create :participation, :even, bill: bill, person: sofie, payment: 100
    FactoryGirl.create :participation, :even, bill: bill, person: hattori, payment: 0
    FactoryGirl.create :participation, :even, bill: bill, person: bb, payment: 0
    debts = Debt.from_bill(bill)

    # Total = 100+0+0 = 100
    # Even share = 100/3 = 33.33333333
    # Sofie needs   = 100-33.333333 = 66.6666666
    # Hattori needs =   0-33.333333 = -33.333333
    # B.B.    needs =   0-33.333333 = -33.333333

    assert_equal 2, debts.size

    assert_equal "Hattori", debts[0].from.name
    assert_equal "Sofie",   debts[0].to.name
    assert_equal 33.33,     debts[0].amount

    assert_equal "B.B.",    debts[1].from.name
    assert_equal "Sofie",   debts[1].to.name
    assert_equal 33.33,     debts[1].amount
  end

end

