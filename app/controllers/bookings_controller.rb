class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus
  before_action :set_seat, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = @seat.bookings.new(booking_params)
    @booking.user = current_user
    @booking_date = Date.new(params[:booking]["booking_date(1i)"].to_i, 
                          params[:booking]["booking_date(2i)"].to_i, 
                          params[:booking]["booking_date(3i)"].to_i)

    # Check if the bus departure time has passed and booking date is in the past
    # debugger
    if @bus.departure_time.strftime("%H:%M:%S") < Time.now.strftime("%H:%M:%S") && @booking_date < Date.today
      flash.now[:alert] = "Booking cannot be made after the departure time of the bus."
      render :new
      return
    end

    if @booking.save
      redirect_to bus_seats_path(@bus), notice: 'Seat was successfully booked.'
    else
      render :new
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
    params.require(:booking).permit(:booking_date)
  end

  def booking_date_in_past?
    # Convert booking_date to a Date object and check if it's in the past
    booking_date = Date.parse(params[:booking][:booking_date])
    booking_date < Date.today
  rescue ArgumentError
    false  # Handle if booking_date cannot be parsed correctly
  end
end
