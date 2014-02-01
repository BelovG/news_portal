class ApplicationController < ActionController::Base
  include TheComments::ViewToken
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    if user_signed_in?
      redirect_to root_path unless current_user.admin?
    else
      redirect_to new_user_session_path
    end
  end




  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
