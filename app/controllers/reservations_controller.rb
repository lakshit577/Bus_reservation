class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bus
    before_action :set_seat, only: [:new, :create]
  
    def new
      @reservation = Reservation.new
    end
  
    def create
        @seat.each do |s|
            # debugger
            @reservation = Reservation.new(reservation_params)
            @reservation.user = current_user
            @reservation.bus = @bus
            @reservation.price = @bus.price_of_a_single_seat
            # @reservation.price = price_per_seat * @seat.count  
            
            @reservation.booking_date = Time.current
            @reservation.seat = s

            if @reservation.save
              
                # seat = Seat.find(seat_id)
                s.update!(selected: false, user_id: nil)
                # @reservation.seats << seat
                redirect_to bus_reservations_path(@bus), notice: 'Reservation was successfully created.'
            else
              render :new, status: :unprocessable_entity
            end
        end
  
    #   selected_seat_ids = reservation_params[:seat_ids].map(&:to_i)
  
#   debugger
    end
  
    private
  
    def set_bus
      @bus = Bus.find(params[:bus_id])
    end
  
    def set_seat
      @seat = Seat.where(selected: true, bus_id: params[:bus_id], user_id: current_user.id)
    end
  
    def reservation_params
      params.require(:reservation).permit(:price, :booking_date, :departure_datetime, :arrival_datetime, seat_ids: [])
    end
  end
  