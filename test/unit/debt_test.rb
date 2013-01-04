require 'test_helper'

class DebtTest < ActiveSupport::TestCase
  context "A debt" do
    setup {
      @oren = create :friend, name: "O-Ren", id: 11111
      @elle = create :friend, name: "Elle", id: 22222
      @debt = Debt.new(from=11111, to=22222, amount=42)
    }

    should "#from " do
      assert_equal 11111, @debt.from
    end

    should "#to" do
      assert_equal 22222, @debt.to
    end

    should "#from_person" do
      assert_equal "O-Ren", @debt.from_person.name
    end

    should "#to_person" do
      assert_equal "Elle", @debt.to_person.name
    end

    should "#amount" do
      assert_equal 42, @debt.amount
    end

    should "#inspect" do
      assert_equal "<Debt 42.0 O-Ren to Elle>", @debt.inspect
    end

    should "#diff_for" do
      assert_equal +42, @debt.diff_for(11111)
      assert_equal -42, @debt.diff_for(22222)
      assert_equal   0, @debt.diff_for(create(:friend).id)
    end
  end

end

