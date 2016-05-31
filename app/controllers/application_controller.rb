class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_close_page, unless: :welcome_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:nickname, :status, :rule_confirmed)
    devise_parameter_sanitizer.for(:account_update).push(:nickname, :status, :rule_confirmed)
  end

  def after_sign_in_path_for(resource)
    if admin_user_signed_in?
      rails_admin_path
    else
      user_path(id: current_user.id)
    end
  end
  def redirect_close_page
    redirect_to :root
  end
  def welcome_controller?
    self.controller_name == 'welcome' || request.fullpath =~ /^[!-~]*admin[!-~]*/
  end
end
