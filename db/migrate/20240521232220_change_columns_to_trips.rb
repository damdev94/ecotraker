class ChangeColumnsToTrips < ActiveRecord::Migration[7.1]
  def change
    remove_column :trips, :start
    remove_column :trips, :end
    add_column :trips, :end_place_id, :integer
    add_column :trips, :start_place_id, :integer
  end
end
