class ChangeBusNumberAndPriceOfSingleSeatInBuses < ActiveRecord::Migration[7.1]
  def change
    change_column :buses, :bus_number, :string
    change_column :buses, :price_of_a_single_seat, :bigint
  end
end
