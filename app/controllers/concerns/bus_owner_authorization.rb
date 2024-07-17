
module BusOwnerAuthorization
    extend ActiveSupport::Concern
  
    included do
      before_action :if_user_is_bus_owner, only: [:new, :create, :reservations, :destroy,:bus_owner_index]
    end
  
    private
  
    def if_user_is_bus_owner
      
      if current_user.role == "customer"
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to root_path # or wherever you want to redirect non-bus owners
      end
    end
  end