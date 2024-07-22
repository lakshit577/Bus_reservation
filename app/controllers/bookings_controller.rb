class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:new, :create, :reservations]

  def new
    @bus = Bus.find(params[:bus_id])
    @date = params[:date]

    if @date.present?
      parsed_date = Date.parse(@date)
      if parsed_date >= Date.today
        @seats = @bus.seats
        unavailable_seats = @bus.seats.joins(:bookings).where(bookings: { booking_date: parsed_date })  
        @seat_ids = unavailable_seats.map(&:id)
      else
        @seats = []
      end
    else
      @seats = []
    end
  end

  def create
    date = params[:date]
    seat_ids = params[:seats]
    result = Bookings::CreateBooking.new(current_user, @bus, seat_ids, date).call
  
    respond_to do |format|
      format.turbo_stream do
        if result.success?
          flash.now[:notice] = result.message
          render turbo_stream: turbo_stream.prepend("modal-content", partial: "bookings/flash_message")          
        else
          flash.now[:alert] = result.message
          render turbo_stream: turbo_stream.prepend("modal-content", partial: "bookings/flash_message"), status: :unprocessable_entity
        end
      end
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
