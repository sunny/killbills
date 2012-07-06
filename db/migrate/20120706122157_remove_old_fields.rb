class RemoveOldFields < ActiveRecord::Migration
  def up
    remove_column :bills, :amount
    remove_column :bills, :friend_id
    remove_column :bills, :user_payed
    remove_column :bills, :friend_payed
    remove_column :bills, :user_ratio
  end

  def down
    add_column :bills, :float, :amount
    add_column :bills, :integer, :friend_id
    add_column :bills, :float, :user_payed
    add_column :bills, :float, :friend_payed
    add_column :bills, :decimal, :user_ratio
    add_index :bills, :friend_id
    add_index :bills, :user_id
  end
end
