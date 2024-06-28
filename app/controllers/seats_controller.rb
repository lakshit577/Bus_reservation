# app/controllers/seats_controller.rb
class SeatsController < ApplicationController
    before_action :set_bus, only: [:new, :create]
  
    def new
        # debugger
        @seats = @bus.seats.order(:seat_number) 
    end
  
    def create
      # debugger
      selected_seat_ids = params[:bus][:seat_ids] if params[:bus].present? && params[:bus][:seat_ids].present?

    
      if selected_seat_ids.empty?
        flash[:alert] = "Please select at least one seat."
        render :new , status: :unprocessable_entity
      else
    
      # ActiveRecord::Base.transaction do
        selected_seat_ids.each do |seat_id|
          seat = @bus.seats.find(seat_id.to_i)  # Convert seat_id to integer
          seat.update!(selected: true, user_id: current_user.id)        
        end

      end
      
      redirect_to new_bus_reservation_path, notice: 'Seats were successfully selected.'
    # rescue ActiveRecord::RecordNotFound => e
    #   redirect_to new_bus_seat_path(@bus), alert: "Seat with ID #{seat_id} not found."
    # rescue ActiveRecord::RecordInvalid => e
    #   flash[:alert] = "Error selecting seats: #{e.message}"
    #   redirect_to new_bus_seat_path(@bus)
    end
    
    private
    
    def set_bus
      @bus = Bus.find(params[:bus_id])
    end
  end
  





  