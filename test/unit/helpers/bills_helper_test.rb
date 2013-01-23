require 'test_helper'

class BillsHelperTest < ActionView::TestCase
  include BillsHelper
  def current_user_or_guest
    @user
  end

  test "#link_to_friend" do
    @user = build(:user)
    friend = build(:friend, name: "Cottonmouth")

    assert_equal "You", link_to_friend(@user)
    assert_match %r{<a.*>Cottonmouth</a>}, link_to_friend(friend)
  end

  test '#debt_summary' do
    @user = build(:user)
    friend = build(:friend, name: "Sofie")
    friend2 = build(:friend, name: "Budd")

    you_owe = Debt.new(@user, friend, 88)
    friend_owes = Debt.new(friend, @user, 88)
    friend_owes_friend = Debt.new(friend, friend2, 88)

    assert_equal "You owe Sofie $88", debt_summary(you_owe)
    assert_equal "Sofie owes you $88", debt_summary(friend_owes)
    assert_equal "Sofie owes Budd $88", debt_summary(friend_owes_friend)

    assert_match %r{^You owe <a.*>Sofie</a> \$88$}, debt_summary(you_owe, links: true)
    assert_match %r{^<a.*>Sofie</a> owes you \$88$}, debt_summary(friend_owes, links: true)
    assert_match %r{^<a.*>Sofie</a> owes <a.*>Budd</a> \$88}, debt_summary(friend_owes_friend, links: true)
  end

  test '#bill_title' do
    beatrix = create :user,   name: "Beatrix"
    vernita = create :friend, name: "Vernita"
    hattori = create :friend, name: "Hattori"
    sophie  = create :friend, name: "Sophie"

    # Payment bill with a paying friend
    bill = build :bill, genre: :payment, user: beatrix
    bill.participations << build(:participation, payment: 8, person: vernita)
    bill.participations << build(:participation, payment: 0, person: beatrix)
    assert_equal "Payment from Vernita", bill_title(bill)

    # Payment bill with a paying user
    bill = build :bill, genre: :payment, user: beatrix
    bill.participations << build(:participation, payment: 8, person: beatrix)
    bill.participations << build(:participation, payment: 0, person: vernita)
    assert_equal "Payment to Vernita", bill_title(bill)

    # A Shared Bill with two friends
    bill = build :bill, :shared, user: beatrix
    bill.participations << build(:participation, payment: 8, person: hattori)
    bill.participations << build(:participation, payment: 5, person: vernita)
    assert_equal "Shared with Hattori and Vernita", bill_title(bill)

    # A Shared Bill with three friends
    bill = build :bill, :shared, user: beatrix
    bill.participations << build(:participation, payment: 9, person: hattori)
    bill.participations << build(:participation, payment: 5, person: vernita)
    bill.participations << build(:participation, payment: 0, person: sophie)
    assert_equal "Shared with Hattori, Sophie, and Vernita", bill_title(bill)

    # A Debt Bill
    bill = build :bill, genre: :debt, user: beatrix
    bill.participations << build(:participation, owed_amount: 4, person: beatrix)
    bill.participations << build(:participation, owed_amount: 2, person: vernita)
    assert_equal "Debt to Vernita", bill_title(bill)
  end

end
