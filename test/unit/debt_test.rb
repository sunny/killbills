require 'test_helper'

class DebtTest < ActiveSupport::TestCase
  context "A debt" do
    setup {
      @oren = create :friend, name: "O-Ren"
      @elle = create :friend, name: "Elle"
      @debt = Debt.new(@oren.id, @elle.id, 42) # from, to, amount
    }

    should "#from #to #from_person #to_person #amount #inspect" do
      assert_equal @oren.id, @debt.from
      assert_equal @elle.id, @debt.to
      assert_equal "O-Ren", @debt.from_person.name
      assert_equal "Elle", @debt.to_person.name
      assert_equal 42, @debt.amount
      assert_equal "<Debt $42 O-Ren to Elle>", @debt.inspect
    end

    should "#diff_for" do
      assert_equal +42, @debt.diff_for(@oren.id)
      assert_equal -42, @debt.diff_for(@elle.id)
      assert_equal   0, @debt.diff_for(create(:friend).id)
    end
  end

end

