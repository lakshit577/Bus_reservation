class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
     
    def not_found
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end


    protected
          def after_sign_in_path_for(resource)
               # debugger
               if resource.role == "bus_owner"
                    bus_owner_home_path
               else
                    root_path
               end
          end


         def configure_permitted_parameters
          #     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email,:password)}
            #   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
                devise_parameter_sanitizer.permit(:sign_up, keys: [:role,:name , :contact])

         end
         private

         def render_not_found(exception)
           logger.error exception.message
           not_found
         end
       end



