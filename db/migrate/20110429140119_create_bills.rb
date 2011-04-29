class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.string :title
      t.float :amount
      t.date :date
      t.integer :user_id
      t.integer :friend_id
      t.float :user_payed
      t.float :friend_payed
      t.decimal :user_ratio, :scale => 2, :precision => 3 # -9.99 to 9.99

      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
