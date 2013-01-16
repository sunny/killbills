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

end
