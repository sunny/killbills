require 'test_helper'

class DebtDecoratorTest < Draper::TestCase
  def sign_in(user)
    warden.stubs(:authenticate!).returns(user)
    controller.stubs(:current_user).returns(user)
  end

  test '#summary' do
    beatrix = create :user
    sophie = build(:friend, name: "Sofie")
    budd   = build(:friend, name: "Budd")
    sign_in beatrix

    debt = Debt.new(beatrix, sophie, 88).decorate
    assert_equal "You owe Sofie $88", debt.summary
    assert_match %r{^You owe <a.*>Sofie</a> \$88$}, debt.summary(links: true)

    debt = Debt.new(sophie, beatrix, 88).decorate
    assert_equal "Sofie owes you $88", debt.summary
    assert_match %r{^<a.*>Sofie</a> owes you \$88$}, debt.summary(links: true)

    debt = Debt.new(sophie, budd, 88).decorate
    assert_equal "Sofie owes Budd $88", debt.summary
    assert_match %r{^<a.*>Sofie</a> owes <a.*>Budd</a> \$88}, debt.summary(links: true)
  end
end
