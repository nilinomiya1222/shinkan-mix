class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :user_registered_express?, if: :devise_controller?
  before_action :set_status, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:nickname, :status)
    devise_parameter_sanitizer.for(:account_update).push(:nickname, :status)
  end

  def after_sign_in_path_for(resource)
    if admin_user_signed_in?
      rails_admin_path
    end
  end

  def register_express_circle
    circle = Circle.where(email: current_user.email)
    circle.update(circle.length, user_id: current_user.id, status: 1)
  end

  def user_registered_express?
    if user_signed_in?
      if current_user.circles.blank? && Circle.where(email: current_user.email).present?
        register_express_circle
      end
    end
  end

  def set_status
    @status = params[:status].to_i
  end

end
