class AddGenreToBills < ActiveRecord::Migration
  def change
    add_column :bills, :genre, :string, default: "Debt"
    say_with_time "Updating previous bills" do
      Bill.update_all(genre: 'Shared')
    end
  end
end
