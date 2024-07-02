class AddNumberOfSeatsToBuses < ActiveRecord::Migration[7.1]
  def change
    add_column :buses, :number_of_seats, :integer, default: 60
  end
end
