class AddSeatNumberToSeats < ActiveRecord::Migration[7.1]
  def change
    add_column :seats, :seat_number, :integer
  end
end
