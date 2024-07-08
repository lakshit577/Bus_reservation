class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:new, :new_multiple, :create]
  before_action :set_seat, only: [:new]


  
  

  def create
    @date = params[:date]
    seat_ids = params[:seats] || []
    if @date.present? && seat_ids.any?
      # debugger
      seat_ids.each do |seat_id|
        Booking.create(user_id: current_user.id, seat_id: seat_id, booking_date: @date ,bus_id: set_bus.id )
      end
      redirect_to bus_path(@bus), notice: "Seats successfully booked for #{@date}"
    else
      redirect_to new_bus_seat_path(@bus), alert: "Please select at least one seat and provide a valid date."
    end
  end

  def reservations
    # debugger
    
    @reservations = @bus.bookings.includes(:seat, :user)
  end


  def user_reservations
    @user = current_user
    @my_reservations = @user.bookings.includes(:seat, :bus)
      
    
  end

  def destroy_reservations
    # debugger
    @reservation = Booking.find(params[:bus_id])
    if @reservation.destroy
      redirect_to user_reservations_bus_bookings_path      , notice: 'Reservation was successfully deleted.'
    else
      render 
    end

  end
  private

  def set_bus
    @bus = Bus.find(params[:bus_id])
  end

  def set_seat
    @seat = @bus.seats.find(params[:seat_id])
  end

  def booking_params
    params.require(:booking).permit(:booking_date, seats: [])
  end
end
