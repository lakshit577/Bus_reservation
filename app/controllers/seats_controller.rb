class SeatsController < ApplicationController
    before_action :set_bus
  
    def index
      @seats = @bus.seats
    end
  
    private
  
    def set_bus
      @bus = Bus.find(params[:bus_id])
    end
  end
  