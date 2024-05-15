class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.float :consumption
      t.string :brand
      t.string :model
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
