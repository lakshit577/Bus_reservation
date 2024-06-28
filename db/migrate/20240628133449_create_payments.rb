class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :bus_id, null: false
      t.integer :user_id, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.boolean :paid, default: false, null: false
      # t.text :seat_ids, array: true, default: []
      # t.integer :no_of_selected_seats, null: false
      # t.text :selected_seat_numbers, array: true, default: []

      t.timestamps
    end

    add_foreign_key :payments, :buses
    add_foreign_key :payments, :users
  end
end



