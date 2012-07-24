require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase

  should "be valid" do
    assert FactoryGirl.create(:participation).valid?
  end

  should "have shared and unshared scopes" do
    even = FactoryGirl.create :participation, owed: "even"
    zero = FactoryGirl.create :participation, owed: "zero"
    all = FactoryGirl.create :participation, owed: "all"

    assert_equal Participation.unshared, [zero, all]
    assert_equal Participation.shared, [even]
  end

  should "have friends and user scopes" do
    friend = FactoryGirl.create :participation
    user = FactoryGirl.create :participation, :from_user

    assert Participation.friends.include?(friend)
    assert Participation.users.include?(user)
    assert_false Participation.friends.include?(user)
    assert_false Participation.users.include?(friend)
  end

  should "#shared?" do
    assert FactoryGirl.build(:participation, owed: "even").shared?
    %w(percentage fixed zero all).each do |owed|
      assert_false FactoryGirl.build(:participation, owed: owed).shared?
    end
  end

  should "#percentage?" do
    assert FactoryGirl.build(:participation, owed: "percentage").percentage?
    %w(even fixed zero all).each do |owed|
      assert_false FactoryGirl.build(:participation, owed: owed).percentage?
    end
  end

  should "#fixed?" do
    assert FactoryGirl.build(:participation, owed: "fixed").fixed?
    %w(even percentage zero all).each do |owed|
      assert_false FactoryGirl.build(:participation, owed: owed).fixed?
    end
  end


  should "have #owed_total return 0 for owed=zero" do
    p = FactoryGirl.create :participation, owed: "zero"
    assert_equal 0, p.owed_total
  end

  should "have #owed_total return total for owed=all" do
    bill = FactoryGirl.create :bill
    FactoryGirl.create :participation, bill: bill, payment: 222
    p = FactoryGirl.create :participation, bill: bill, payment: 333,
      owed: "all"
    assert_equal 222+333, p.owed_total
  end

  should "have #owed_total return a % for owed=percentage" do
    bill = FactoryGirl.create :bill
    FactoryGirl.create :participation, bill: bill, payment: 444
    p = FactoryGirl.create :participation, bill: bill, payment: 555,
      owed: "percentage", owed_percent: 60
    assert_equal (444+555)*0.60, p.owed_total
  end

  should "have #owed_total return the fixed amount for owed=fixed" do
    p = FactoryGirl.create :participation, owed: "fixed", owed_amount: 666
    assert_equal 666, p.owed_total
  end

  should "have #owed_total return half the amount for owed=even" do
    bill = FactoryGirl.create :bill
    p1 = FactoryGirl.create :participation, bill: bill, owed: "even", payment: 7
    p2 = FactoryGirl.create :participation, bill: bill, owed: "even", payment: 8
    assert_equal (7+8)/2.0, p1.owed_total
    assert_equal (7+8)/2.0, p2.owed_total
  end


  should "remove payment with Debt bills" do
    bill = FactoryGirl.create :bill, genre: :debt
    participation = FactoryGirl.create :participation, bill: bill, owed: "even", payment: 4
    assert_nil participation.payment
  end

  should "remove owed_amount field with Payment bills" do
    bill = FactoryGirl.create :bill, genre: :payment
    participation = FactoryGirl.create :participation, bill: bill, owed: "even", owed_amount: 4
    assert_nil participation.owed_amount
  end

end

