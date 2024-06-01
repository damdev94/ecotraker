class AddDistanceToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :distance, :float
  end
end
