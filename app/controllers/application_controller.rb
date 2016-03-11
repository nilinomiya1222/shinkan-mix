class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :user_registered_express?, if: :devise_controller?
  before_action :set_status, if: :devise_controller?

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

  def register_express_circle
    e_circle = ECircle.where(email: current_user.email)[0]
    Circle.create(user_id: current_user.id ,circle_genre_id: e_circle.circle_genre_id ,campus: e_circle.campus ,name: e_circle.name ,name_kana: e_circle.name_kana ,email: e_circle.email ,phone: e_circle.phone ,phone_possible: e_circle.phone_possible ,chief: e_circle.chief ,chief_kana: e_circle.chief_kana ,sub_chief: e_circle.sub_chief ,member_male: e_circle.member_male ,member_female: e_circle.member_female ,since: e_circle.since ,entrance_fee: e_circle.entrance_fee ,annual_fee: e_circle.annual_fee ,active_weeks: e_circle.active_weeks ,active_times: e_circle.active_times ,hangout: e_circle.hangout ,location: e_circle.location ,camp: e_circle.camp ,join_grades: e_circle.join_grades ,appeal: e_circle.appeal ,pr: e_circle.pr ,hp: e_circle.hp ,twitter: e_circle.twitter ,facebook: e_circle.facebook, status: 1)
  end

  def user_registered_express?
    if user_signed_in?
      if current_user.circles.blank? && ECircle.where(email: current_user.email).present?
        register_express_circle
      end
    end
  end

  def set_status
    @status = params[:status].to_i
  end

end
