class AddColumnVehicleToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :vehicle, :string
  end
end
