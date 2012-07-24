class AddGenreToBills < ActiveRecord::Migration
  def change
    add_column :bills, :genre, :string, default: "debt"
    say_with_time "Updating previous bills to be shared bills" do
      Bill.update_all(genre: 'shared')
    end
  end
end
