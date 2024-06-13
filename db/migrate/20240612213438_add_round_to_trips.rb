class AddRoundToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :round, :boolean, default: false
  end
end
