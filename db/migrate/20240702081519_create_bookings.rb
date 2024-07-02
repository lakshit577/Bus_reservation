class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.date :booking_date, null: false

      t.timestamps
    end
  end
end
