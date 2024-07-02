class CreateBuses < ActiveRecord::Migration[7.1]
  def change
    create_table :buses do |t|
      t.string :bus_name
      t.integer :bus_number
      t.integer :bus_type, default: 0
      t.integer :price_of_a_single_seat
      t.time :departure_time
      t.string :departure_location
      t.time :arrival_time
      t.string :arrival_location

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
