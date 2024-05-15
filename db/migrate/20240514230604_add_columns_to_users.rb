class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :address, :string
    add_column :users, :score, :integer, default: 0
    add_column :users, :pseudo, :string
  end
end
