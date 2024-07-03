class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:new, :new_multiple, :create]
  before_action :set_seat, only: [:new]

  def new
    @booking = Booking.new
  end

  def new_multiple
    @seats = @bus.seats.where(id: params[:seats])
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
      unless booking.save
        redirect_to bus_seats_path(@bus), notice: 'Seats were successfully booked.'
        # redirect_to bus_seats_path(@bus), alert: "Error booking seat #{seat.seat_number}."
        return
      end
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
