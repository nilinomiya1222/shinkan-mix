class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :circle_owner?, only: [:new, :create, :edit, :update, :publish]
  before_action :owner_registered_circle?, only: [:edit, :update, :publish]
  before_action :set_circle, only: [:show, :edit, :update, :publish]
  before_action :circle_published?, only: :show
  before_action :set_genres

  def index
    @circles = Circle.where(status: 1)
  end

  def show
  end

  def new
    if current_user.circles.blank?
      flash[:warning] = 'サークル情報を登録してください'
    end
    @circle = Circle.new
  end

  def create
    @circle = current_user.circles.new(circle_params)
    if @circle.save
      flash[:success] = 'サークル情報が投稿されました'
      redirect_to :root and return
    else
      render :new
      flash[:error] = '投稿に失敗しました'
    end
  end

  def edit
  end

  def update
    if @circle.user_id == current_user.id
      if @circle.update(circle_params)
        redirect_to controller: 'users', action: 'show', id: current_user.id
        flash[:success] = 'サークル情報が更新されました'
      else
        render :edit, danger: 'サークル情報の更新に失敗しました'
      end
    end
  end

  def publish
    if @circle.published?
      @circle.closed!
      redirect_to circle_path(@circle)
      flash[:success] = 'サークル情報を非公開にしました。'
    else
      @circle.published!
      redirect_to circle_path(@circle)
      flash[:success] = 'サークル情報を公開しました。'
    end
  end

  def search
    @circles = Circle.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  private
  def circle_owner?
    unless current_user.owner?
      redirect_to :root and return
    end
  end

  def owner_registered_circle?
    unless Circle.where(email: current_user.email)
      redirect_to :new, info: 'サークル情報を登録してください' and return
    end
  end

  def set_circle
    @circle = Circle.find(params[:id])
  end

  def set_genres
    @circle_genres = CircleGenre.all
  end

  def circle_params
    params.require(:circle).permit(:name, :name_kana, :pr, :join_grades, :circle_genre_id, :booth).merge(email: current_user.email)
  end

  def circle_published?
    unless @circle.published?
      redirect_to :root
      return
    end
  end
end
