class BusesController < ApplicationController
  before_action :authenticate_user!
  before_action :if_user_is_bus_owner, only: [:new, :create,:reservations,:destroy]


  def reservations
    # debugger
    @bus = Bus.find(params[:id])
    @reservations = @bus.bookings.includes(:seat, :user)
  end

  def user_reservations
    @user = current_user
    @my_reservations = @user.bookings.includes(:seat, :bus)
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

  def destroy
    @bus = Bus.find(params[:id])
    @bus.destroy
    respond_to do |format|
      format.html { redirect_to buses_url, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
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


