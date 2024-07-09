class SeatsController < ApplicationController
  rescue_from AbstractController::ActionNotFound, with: :render_404

  before_action :set_bus

  # app/controllers/seats_controller.rb

def new
  
  @date = params[:date]
  # debugger

  if @date.present?
    @seats = @bus.seats.includes(:bookings).select { |seat| seat.available?(Date.parse(@date)) }
  else
    @seats = []
  end
end

  # def create
  #   @date = params[:date]
  #   seat_ids = params[:seats] || []
  #   if @date.present? && seat_ids.any?
  #     # debugger
  #     seat_ids.each do |seat_id|
  #       Booking.create(user_id: current_user.id, seat_id: seat_id, booking_date: @date ,bus_id: set_bus.id )
  #     end
  #     redirect_to bus_path(@bus), notice: "Seats successfully booked for #{@date}"
  #   else
  #     redirect_to new_bus_seat_path(@bus), alert: "Please select at least one seat and provide a valid date."
  #   end
  # end

  private

  def set_bus
    @bus = Bus.find(params[:bus_id])
  end

  def permit_params
    params.require(:seat).permit(:seat_number)
  end
end
