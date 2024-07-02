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
end
