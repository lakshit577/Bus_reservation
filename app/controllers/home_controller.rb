class HomeController < ApplicationController

  before_action :authenticate_user! ,except: :index
  before_action :if_user_is_bus_owner ,only: [:bus_owner_index]
  before_action :all_buses ,only: [:bus_owner_index,:index]

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
  
  def if_user_is_bus_owner
    
    if current_user.role == "customer"
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to root_path # or wherever you want to redirect non-bus owners
    end
  end
  def all_buses
    @buses = Bus.all
  end

end
