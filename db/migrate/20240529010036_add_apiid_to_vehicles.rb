class AddApiidToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :carbon_kg, :integer
    add_column :vehicles, :api_id, :string
  end
end
