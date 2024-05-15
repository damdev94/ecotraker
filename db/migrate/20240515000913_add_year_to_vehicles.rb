class AddYearToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :year, :string
  end
end
