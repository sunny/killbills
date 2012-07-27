class RenameOwedColumn < ActiveRecord::Migration
  def change
    rename_column :participations, :owed, :owed_type
  end
end
