class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :type, :index => true
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
