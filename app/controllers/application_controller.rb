class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?




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
end



