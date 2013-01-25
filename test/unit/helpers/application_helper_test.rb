# encoding: utf-8
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  def current_user_or_guest
    @user
  end

  test "#user_number_to_currency" do
    @user = build(:user, currency: "EUR")
    assert_equal "€8.80",  user_number_to_currency(8.8)
    assert_equal "€88.88", user_number_to_currency(88.88)
    assert_equal "€88",    user_number_to_currency(87.999)

    @user = build(:user, currency: "USD")
    assert_equal "$8", user_number_to_currency(8.00)
  end

  test "#number_to_currency_without_double_zeros" do
    assert_equal "$8",    number_to_currency_without_double_zeros(8.0)
    assert_equal "$8.80", number_to_currency_without_double_zeros(8.8)
    assert_equal "$8.88", number_to_currency_without_double_zeros(8.88)

    options = {
      format: "%n %u",
      unit: "€",
      separator: ",",
      delimiter: " ",
    }
    assert_equal "8 €",        number_to_currency_without_double_zeros(8.0, options)
    assert_equal "8,80 €",     number_to_currency_without_double_zeros(8.8, options)
    assert_equal "8 888,88 €", number_to_currency_without_double_zeros(8888.88, options)
  end

  test '#variation' do
    assert_equal :positive, variation(+1)
    assert_equal :negative, variation(-1.0)
    assert_equal :zero,     variation(0)
  end

  test "#link_to_friend" do
    @user = build(:user)
    friend = build(:friend, name: "Cottonmouth")

    assert_equal "You", link_to_friend(@user)
    assert_match %r{<a.*>Cottonmouth</a>}, link_to_friend(friend)
  end

  test '#incrementer!' do
    assert_equal 1, incrementer!
    assert_equal 1, incrementer!(:foo)
    assert_equal 2, incrementer!
    assert_equal 2, incrementer!(:foo)
  end

  test '#incrementer' do
    2.times { incrementer! }
    5.times { incrementer!(:foo) }
    assert_equal 2, incrementer
    assert_equal 2, incrementer
    assert_equal 5, incrementer(:foo)
  end

  test '#current_currency' do
    @user = build(:user, currency: nil)
    assert_equal "$", current_currency

    @user = build(:user, currency: "EUR")
    assert_equal "€", current_currency
  end
end
