class HomeController < ApplicationController

  before_action :authenticate_user! ,except: :index

  def index
    
  end

  def bus_owner_index

  end

  
end
