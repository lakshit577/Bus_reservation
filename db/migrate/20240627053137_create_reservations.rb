# db/migrate/20240626120001_create_reservations.rb
class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bus, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true, unique: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.datetime :booking_date, null: false


      t.timestamps
    end
  end
end