require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase

  should "be valid" do
    assert FactoryGirl.create(:participation).valid?
  end

  should "have shared and unshared scopes" do
    even = FactoryGirl.create :participation, owed_type: "even"
    zero = FactoryGirl.create :participation, owed_type: "zero"
    all = FactoryGirl.create :participation, owed_type: "all"

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
    assert FactoryGirl.build(:participation, owed_type: "even").shared?
    %w(fixed zero all).each do |owed_type|
      assert_false FactoryGirl.build(:participation, owed_type: owed_type).shared?
    end
  end

  # should "#percentage?" do
  #   assert FactoryGirl.build(:participation, owed_type: "percentage").percentage?
  #   %w(even fixed zero all).each do |owed_type|
  #     assert_false FactoryGirl.build(:participation, owed_type: owed_type).percentage?
  #   end
  # end

  should "#fixed?" do
    assert FactoryGirl.build(:participation, owed_type: "fixed").fixed?
    %w(even zero all).each do |owed_type|
      assert_false FactoryGirl.build(:participation, owed_type: owed_type).fixed?
    end
  end


  should "have #owed_total return 0 for owed_type=zero" do
    p = FactoryGirl.create :participation, owed_type: "zero"
    assert_equal 0, p.owed_total
  end

  should "have #owed_total return total for owed_type=all" do
    bill = FactoryGirl.create :bill
    FactoryGirl.create :participation, bill: bill, payment: 222
    p = FactoryGirl.create :participation, bill: bill, payment: 333, owed_type: "all"
    assert_equal 222+333, p.owed_total
  end

  # should "have #owed_total return a % for owed_type=percentage" do
  #   bill = FactoryGirl.create :bill
  #   FactoryGirl.create :participation, bill: bill, payment: 444
  #   p = FactoryGirl.create :participation, bill: bill, payment: 555,
  #     owed_type: "percentage", owed_percent: 60
  #   assert_equal (444+555)*0.60, p.owed_total
  # end

  should "have #owed_total return the fixed amount for owed_type=fixed" do
    p = FactoryGirl.create :participation, owed_type: "fixed", owed_amount: 666
    assert_equal 666, p.owed_total
  end

  should "have #owed_total return half the amount for owed_type=even" do
    bill = FactoryGirl.create :bill
    p1 = FactoryGirl.create :participation, bill: bill, owed_type: "even", payment: 7
    p2 = FactoryGirl.create :participation, bill: bill, owed_type: "even", payment: 8
    assert_equal (7+8)/2.0, p1.owed_total
    assert_equal (7+8)/2.0, p2.owed_total
  end


  should "remove payment with Debt bills" do
    bill = FactoryGirl.create :bill, genre: :debt
    participation = FactoryGirl.create :participation, bill: bill,
      owed_type: "even", payment: 4
    assert_nil participation.payment
  end

  should "remove owed_amount field with Payment bills" do
    bill = FactoryGirl.create :bill, genre: :payment
    participation = FactoryGirl.create :participation, bill: bill,
      owed_type: "even", owed_amount: 4
    assert_nil participation.owed_amount
  end

end

