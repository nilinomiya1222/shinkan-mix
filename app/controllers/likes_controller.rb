class LikesController < ApplicationController
  def create
    @circle = Circle.find(params[:circle_id])
    current_user.likes.create(circle_id: params[:circle_id])
  end
  def destroy
    Like.find_by(user_id: current_user.id, circle_id: params[:id]).destroy
    @circle = Circle.find(params[:circle_id])
  end
end
