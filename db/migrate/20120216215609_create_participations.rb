class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :bill_id, :null => false
      t.integer :person_id
      t.float   :payment
      t.string  :owed
      t.float   :owed_amount
      t.integer :owed_percent
      t.timestamps
    end
    add_index :participations, :bill_id
    add_index :participations, :person_id
  end
end

