class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:new, :create, :reservations]

  def new
    @bus = Bus.find(params[:bus_id])
    @date = params[:date]

    if @date.present?
      begin
        parsed_date = Date.parse(@date)
        if parsed_date >= Date.today
          @seats = @bus.seats
          unavailable_seats = @bus.seats.includes(:bookings).select { |seat| !seat.available?(parsed_date) }
          @seat_ids = unavailable_seats.map(&:id)
        else
          @seats = []
        end
      rescue ArgumentError
        @seats = []
      end
    else
      @seats = []
    end
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def create
    date = params[:date] 
    seat_ids = params[:seats] || []

    if Date.parse(date) >= Date.today
      if @bus.bookings.where(seat_id: seat_ids, booking_date: date).present?
        redirect_to bus_path(@bus), alert: "already booked"
      elsif result = Bookings::CreateBooking.new(current_user, @bus, seat_ids, date).call
        respond_to do |format|
          format.turbo_stream {
            redirect_to bus_path(@bus), notice: "Booking created successfully"
          }
        end
      else
        redirect_to bus_path(@bus), alert: result.message
      end
    else
      redirect_to bus_path(@bus), alert: "Invalid date"
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

  def booking_params
    params.require(:booking).permit(:booking_date, seats: [])
  end
end
