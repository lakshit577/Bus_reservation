class BusesController < ApplicationController
  before_action :authenticate_user!
  include BusOwnerAuthorization

  def bus_owner_index
    @buses = current_user.buses
  end

  def show
    @bus = Buses::ShowBus.new(params[:id]).call
  end

  def new
    @bus = Buses::NewBus.new(current_user).call
  end

  def create
    result = Buses::CreateBus.new(current_user, permit_params).call

    if result.success?
      redirect_to bus_owner_home_path, notice: result.message
    else
      @bus = current_user.buses.create(permit_params)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bus = Bus.find(params[:id])
    if @bus.destroy
      respond_to do |format|
        format.html { redirect_to bus_owner_index_buses_path, notice: 'Bus was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render :new
    end
  end

  private

  def permit_params
    params.require(:bus).permit(:bus_name, :bus_number, :bus_type, :price_of_a_single_seat, :departure_time, :departure_location, :arrival_time, :arrival_location, :number_of_seats)
  end
end
