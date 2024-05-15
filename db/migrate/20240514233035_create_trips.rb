class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :start
      t.string :end
      t.string :label
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
