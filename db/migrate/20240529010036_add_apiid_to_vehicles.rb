class AddApiidToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :carbon_kg, :integer
  end
end
