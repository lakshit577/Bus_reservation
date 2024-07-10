class SeatsController < ApplicationController
  rescue_from AbstractController::ActionNotFound, with: :render_404

  before_action :set_bus

def new
  
  @date = params[:date]

  if @date.present?
    @seats = @bus.seats.includes(:bookings).select { |seat| seat.available?(Date.parse(@date)) }
  else
    @seats = []
  end
end
  private

  def set_bus
    @bus = Bus.find(params[:bus_id])
  end

  def permit_params
    params.require(:seat).permit(:seat_number)
  end
end
