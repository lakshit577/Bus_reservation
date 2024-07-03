class SeatsController < ApplicationController
    before_action :set_bus
  
    def index
      
      @date = params[:date]
  
      if @date.present?
        @seats = @bus.seats.includes(:bookings).select { |seat| seat.bookings.none? { |booking| booking.booking_date == Date.parse(@date) } }
      else
        @seats = []
      end
    end
  
    private
  
    def set_bus
      @bus = Bus.find(params[:bus_id])
    end
  end
  