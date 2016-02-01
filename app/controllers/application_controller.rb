class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_status, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:nickname, :status)
    devise_parameter_sanitizer.for(:account_update).push(:nickname, :status)
  end

  def after_sign_in_path_for(resource)
    unless admin_user_signed_in?
      if current_user.owner?
        if user_registered_express?(current_user)
          new_circle_path
          return
        elsif user_registered_circle?(current_user)
          circle = Circle.where(email: current_user.email)
          circle.update(circle.length, user_id: current_user.id, status: 1)
          redirect_to user_path(current_user) and return
        else
          root_path
          return
        end
      else
        root_path
        return
      end
    else
      rails_admin_path
    end
  end

  def user_registered_express?(user)
    Circle.where(email: user.email).blank?
  end

  def user_registered_circle?(user)
    user.circles.blank?
  end

  def set_status
    @status = params[:status].to_i
  end

end
