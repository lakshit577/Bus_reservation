class AddUserIdToSeats < ActiveRecord::Migration[7.1]
  def change
    add_reference :seats, :user, foreign_key: true
  end
end
