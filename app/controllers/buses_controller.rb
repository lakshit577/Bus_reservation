class BusesController < ApplicationController
    before_action :authenticate_user!
  before_action :if_user_is_bus_owner
    # before_action :if_user_is_bus_owner

    def index
        @buses = Bus.all
    end

    # to create a new bus-----------------------------

    def new
        @user=current_user
        @bus = Bus.new 
    end
    def create
        @bus = Bus.new(permit_params)
        @bus.user = current_user
        if @bus.save
            redirect_to bus_owner_home_path
        else
            render :new
        end
    end



    # to show all the buses ---------------------------------
    def show
        
    end


    private

    def permit_params
        params.require(:bus).permit(:bus_name, :bus_number, :bus_type, :availabe_seats, :price_of_a_single_seat, :departure_datetime, :departure_location, :arrival_datetime, :arrival_location)
    end

    def if_user_is_bus_owner
        # debugger
        if current_user.role == "customer"
            flash[:alert] = 'You are not authorized to perform this action.'
            redirect_to root_path # or wherever you want to redirect non-bus owners
        end
    end
end
