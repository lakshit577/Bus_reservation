class BusesController < ApplicationController
    before_action :authenticate_user!
    before_action :if_user_is_bus_owner, except: [:index, :show]
  
    def index
      @buses = Bus.all
    end
  
    def new
      @user = current_user
      @bus = Bus.new 
    end
  
    def create
      @bus = Bus.new(permit_params)
      @bus.user = current_user
      if @bus.save
        # Create seats for the bus
        @bus.number_of_seats.times do |index|
          @bus.seats.create!(seat_number: index + 1)
        end
        redirect_to bus_owner_home_path, notice: 'Bus and seats were successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def show
    #   @bus = Bus.find(params[:id])
    end
  
    private
  
    def permit_params
      params.require(:bus).permit(:bus_name, :bus_number, :bus_type, :number_of_seats, :price_of_a_single_seat, :departure_datetime, :departure_location, :arrival_datetime, :arrival_location)
    end
  
    def if_user_is_bus_owner
      if current_user.role == "customer"
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to root_path
      end
    end
  end
  