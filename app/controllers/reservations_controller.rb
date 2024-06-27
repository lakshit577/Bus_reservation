class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bus
    before_action :set_seat

    def new
        @reservation = Reservation.new
    end

  

    private

    def set_bus
        @bus = Bus.find(params[:bus_id])
    end

    def set_seat
        # @seat = Seat.find(params[:seat_id])
        # debugger
        @seat =Seat.where(selected: true ,bus_id: params[:bus_id])

    end

    def reservation_params
        params.require(:reservation).permit(:price)
      end
end


