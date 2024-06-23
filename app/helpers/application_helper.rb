module ApplicationHelper
    def on_auth_page?
      devise_controller? && (action_name == 'new' && (controller_name == 'sessions' || controller_name == 'registrations'))
    end
  end
  