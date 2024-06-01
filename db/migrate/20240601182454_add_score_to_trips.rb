class AddScoreToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :score, :float, default: 0
  end
end
