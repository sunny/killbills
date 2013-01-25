require 'test_helper'

class BillDecoratorTest < Draper::TestCase
  def sign_in(user)
    warden.stubs(:authenticate!).returns(user)
    controller.stubs(:current_user).returns(user)
  end

  test '#title' do
    beatrix = create :user
    vernita = create :friend, name: "Vernita"
    hattori = create :friend, name: "Hattori"
    sophie  = create :friend, name: "Sophie"
    sign_in beatrix

    # Payment bill with a paying friend
    bill = build :bill, genre: :payment, user: beatrix
    bill.participations << build(:participation, payment: 8, person: vernita)
    bill.participations << build(:participation, payment: 0, person: beatrix)
    assert_equal "Payment from Vernita", bill.decorate.title

    # Payment bill with a paying user
    bill = build :bill, genre: :payment, user: beatrix
    bill.participations << build(:participation, payment: 8, person: beatrix)
    bill.participations << build(:participation, payment: 0, person: vernita)
    assert_equal "Payment to Vernita", bill.decorate.title

    # A Shared Bill with two friends
    bill = build :bill, :shared, user: beatrix
    bill.participations << build(:participation, payment: 8, person: hattori)
    bill.participations << build(:participation, payment: 5, person: vernita)
    assert_equal "Shared with Hattori and Vernita", bill.decorate.title

    # A Shared Bill with three friends
    bill = build :bill, :shared, user: beatrix
    bill.participations << build(:participation, payment: 9, person: hattori)
    bill.participations << build(:participation, payment: 5, person: vernita)
    bill.participations << build(:participation, payment: 0, person: sophie)
    assert_equal "Shared with Hattori, Sophie, and Vernita", bill.decorate.title

    # A Debt Bill
    bill = build :bill, genre: :debt, user: beatrix
    bill.participations << build(:participation, owed_amount: 4, person: beatrix)
    bill.participations << build(:participation, owed_amount: 2, person: vernita)
    assert_equal "Debt to Vernita", bill.decorate.title
  end

end
