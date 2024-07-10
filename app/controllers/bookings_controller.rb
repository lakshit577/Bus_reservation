# app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:new, :create, :reservations]
  before_action :set_seat, only: [:new]

  def create
    @date = params[:date]
    seat_ids = params[:seats] || []
    result = Bookings::CreateBooking.new(current_user, @bus, seat_ids, @date).call

    if result.success?
      redirect_to bus_path(@bus), notice: result.message
    else
      redirect_to new_bus_seat_path(@bus), alert: result.message
    end
  end

  def reservations
    @reservations = @bus.bookings.includes(:seat, :user)
  end

  def user_reservations
    @user = current_user
    @my_reservations = @user.bookings.includes(:seat, :bus)
  end

  def destroy_reservations
    @reservation = Booking.find(params[:bus_id])
    result = Bookings::DestroyBooking.new(@reservation).call

    if result.success?
      redirect_to user_reservations_bus_bookings_path, notice: result.message
    else
      redirect_to user_reservations_bus_bookings_path, alert: result.message
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
