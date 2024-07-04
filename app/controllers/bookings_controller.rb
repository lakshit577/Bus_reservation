class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:new, :new_multiple, :create]
  before_action :set_seat, only: [:new]

  def new
    @booking = Booking.new
  end
  
  def new_multiple
    # debugger
    @seats = @bus.seats.where(id: params[:seats])
    # debugger
    @booking_date = params[:date]
    if @seats.empty?
      redirect_to bus_seats_path(@bus), alert: "No seats selected."
    end
  end

  def create
    # debugger
    seat_ids = params[:booking][:seats]
    booking_date =    params[:booking_date]

   
    seat_ids.each do |seat_id|
    
      seat = @bus.seats.find(seat_id)
      booking = seat.bookings.new(user: current_user, booking_date: booking_date)
      debugger
      if booking_date != @date
        p  "dont change the date"
      else
        booking.save
      end
    end

     
      redirect_to home_index_path, notice: 'Seats were successfully booked.'
  
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
