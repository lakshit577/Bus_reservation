class BusesController < ApplicationController

  before_action :authenticate_user!
  before_action :if_user_is_bus_owner, only: [:new, :create]

  def index
    @buses = Bus.all
  end

  def bus_owner_index
    @buses = current_user.buses
  end

  def show
    @bus = Bus.find(params[:id])
  end

  def new
    @user = current_user
    @bus = Bus.new
  end
  
  def create
    @bus = Bus.new(permit_params)
    @bus.user = current_user
    if @bus.save
      redirect_to bus_owner_home_path, notice: 'Bus was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def permit_params
    params.require(:bus).permit(:bus_name, :bus_number, :bus_type, :price_of_a_single_seat, :departure_time, :departure_location, :arrival_time, :arrival_location)
  end

  def if_user_is_bus_owner
    if current_user.role == "customer"
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to root_path # or wherever you want to redirect non-bus owners
    end
  end
end


