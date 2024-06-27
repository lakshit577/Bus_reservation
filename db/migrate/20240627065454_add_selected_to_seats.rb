class AddSelectedToSeats < ActiveRecord::Migration[7.1]
  def change
    add_column :seats, :selected, :boolean,default: false
  end
end