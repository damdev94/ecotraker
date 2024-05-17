class AddVehicleRefToTrips < ActiveRecord::Migration[7.1]
  def change
    add_reference :trips, :vehicle, null: false, foreign_key: true
  end
end
