# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def destroy
    # debugger
    clear_selected_seats_for_current_user
    super
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  def clear_selected_seats_for_current_user
    return unless current_user

    current_user.buses.each do |bus|
      bus.seats.where(selected: true, user_id: current_user.id).update_all(selected: false, user_id: nil)
    end
  end
end
