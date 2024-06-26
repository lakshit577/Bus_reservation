class SeatsController < ApplicationController
    before_action :set_bus
    
    def new
        @seats = []
        @bus.number_of_seats.times do |index|
        @seats << @bus.seats.build(seat_number: index + 1)
        end
    end

    # def create
    #     @seats = params[:bus][:seats_attributes].values.map do |seat_params|
    #       @bus.seats.build(seat_params)
    #     end
    
    #     if @bus.save
    #       redirect_to @bus, notice: 'Seats were successfully selected.'
    #     else
    #       render :new
    #     end
    #   end

    private
    def set_bus 
        @bus = Bus.find(params[:bus_id])
    end
end