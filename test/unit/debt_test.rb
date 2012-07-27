require 'test_helper'

class DebtTest < ActiveSupport::TestCase
  context "A debt" do
    setup {
      @oren = build :friend, name: "O-Ren"
      @elle = build :friend, name: "Elle"
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
      assert_equal   0, @debt.diff_for(build(:friend))
    end
  end

end

