class AddAvailableSeatsToBuses < ActiveRecord::Migration[7.1]
  def change
    add_column :buses, :available_seats, :integer,default: 50
  end
end
