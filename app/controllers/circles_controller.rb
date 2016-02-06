class CirclesController < ApplicationController
  before_action :authenticate_admin_user!, except: [:index, :show, :search]
  before_action :set_circle, only: [:show, :edit, :update, :publish]
  before_action :circle_published?, only: :show
  before_action :set_genres

  def index
    @circles = Circle.where(status: 1)
  end

  def show
  end

  def search
    @circles = Circle.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  private
  def set_circle
    @circle = Circle.find(params[:id])
  end

  def set_genres
    @circle_genres = CircleGenre.all
  end

  def circle_published?
    unless @circle.published?
      redirect_to :root
      return
    end
  end
end
