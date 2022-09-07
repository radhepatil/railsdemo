# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # skip_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   #  if !current_user
   #   session[:attendee] = true
   #   redirect_to user_session_path
   # else
   #  super
   # end`
  def create
    super do |resource|
      BackgroundWorker.trigger(resource)
    end
  end
  # DELETE /resource/sign_out
  def destroy
    super
    
  end

  protected

#  def after_sign_in_path_for(resource_or_scope)
#   if session[:attendee]
#     previous_url = session[:previous_url]
#     session[:previous_url] = nil #clear session
#     previous_url #going back to event page
#   else
#     super
#   end
# end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
