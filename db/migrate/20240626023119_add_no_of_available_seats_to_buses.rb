class AddNoOfAvailableSeatsToBuses < ActiveRecord::Migration[7.1]
  def change
    add_column :buses, :no_of_available_seats, :integer,default: 50
  end
end
