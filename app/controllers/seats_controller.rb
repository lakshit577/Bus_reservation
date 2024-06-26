class SeatsController < ApplicationController
    before_action :set_bus
    
    def new
        @seats = []
        @bus.number_of_seats.times do |index|
        @seats << @bus.seats.build(seat_number: index + 1)
        end
    end

    def create
        
    end

    private
    def set_bus 
        @bus = Bus.find(params[:bus_id])
    end
end