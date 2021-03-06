class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:show]

  def show
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
    else
      redirect_to circles_path
    end
  end
end
