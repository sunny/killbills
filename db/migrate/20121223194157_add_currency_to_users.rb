class AddCurrencyToUsers < ActiveRecord::Migration
  def change
    add_column :people, :currency, :string, default: 'USD'
  end
end
