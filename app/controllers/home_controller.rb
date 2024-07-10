class HomeController < ApplicationController

  before_action :authenticate_user! ,except: :index
  before_action :all_buses ,only: [:bus_owner_index,:index]
  include BusOwnerAuthorization

  def index
   
      @buses = if params[:bus_name].present?
        Bus.where(bus_name: params[:bus_name])
      else
        Bus.all
      end
      
    

  end
  
  def bus_owner_index
    @buses = if params[:bus_name].present?
      Bus.where(bus_name: params[:bus_name])
    else
      Bus.all
    end

  end



  private
  
  
  def all_buses
    @buses = Bus.all
  end

end
