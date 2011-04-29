class ModifyBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :user_payed, :float 
    add_column :bills, :friend_payed, :float
    add_column :bills, :user_ratio, :decimal,
      :scale => 2, :precision => 3 # -9.99 to 9.99
  end

  def self.down
    remove_column :bills, :user_payed
    remove_column :bills, :friend_payed
    remove_column :bills, :user_ratio
  end
end
