require 'test_helper'


class ActiveRecordExtensionsTest < ActiveSupport::TestCase
  should "add errors with #errors_on_group" do
    bill = build(:bill)
    participation1 = build(:participation)
    participation2 = build(:participation)
    bill.participations = [participation1, participation2]

    bill.errors_on_group(:participations, :payment, bill.participations, "is in error")

    assert_equal ["is in error"], bill.errors[:"participations.payment"]
    assert_equal ["is in error"], participation1.errors[:payment]
    assert_equal ["is in error"], participation2.errors[:payment]
  end

  should "#touch_all on relations" do
    bill = create(:bill, updated_at: 2.days.ago)
    old_updated_at = bill.updated_at

    relation = Bill.where(id: bill)
    relation.touch_all

    assert relation.first.updated_at > old_updated_at
  end
end

