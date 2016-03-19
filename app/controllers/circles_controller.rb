class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :circle_owner?, only: [:new, :create, :edit, :update, :publish]
  before_action :owner_registered_circle?, only: [:edit, :update, :publish]
  before_action :set_circle, only: [:show, :edit, :update, :publish]
  before_action :circle_registered?, only: :show
  before_action :set_genres

  def index
    @circles = Circle.where.not(status: 0).page(params[:page])
  end

  def show
    @events = @circle.events.page(params[:page])
  end

  def new
    if current_user.circles.blank?
      if ECircle.where(email: current_user.email).present?
        register_express_circle
        redirect_to controller: 'users', action: 'show', id: current_user.id and return
      end
      flash[:warning] = 'サークル情報を登録してください'
    end
    @circle = Circle.new
  end

  def create
    @circle = current_user.circles.new(circle_params)
    if @circle.save
      flash[:success] = 'サークル情報が投稿されました'
      redirect_to circle_path(@circle)
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
        redirect_to circle_path(@circle)
        flash[:success] = 'サークル情報が更新されました'
      else
        render :edit, danger: 'サークル情報の更新に失敗しました'
      end
    end
  end

  def publish
    if @circle.published?
      @circle.registered!
      redirect_to circle_path(@circle)
      flash[:success] = 'Milestone Express掲載情報を非公開にしました。'
    else
      @circle.published!
      redirect_to circle_path(@circle)
      flash[:success] = 'Milestone Express掲載情報を公開しました。'
    end
  end


  def search
    @circles = Circle.where('name LIKE(?)', "%#{params[:keyword]}%").page(params[:page])
  end

  private
  def circle_owner?
    unless current_user.owner?
      redirect_to circles_path and return
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
    params[:circle][:twitter].delete!("@")
    params.require(:circle).permit(:name, :name_kana, :pr, :join_grades, :circle_genre_id, :booth, :phone, :phone_possible, :campus, :show_email, :facebook, :twitter).merge(email: current_user.email)
  end

  def circle_registered?
    if @circle.closed?
      redirect_to circles_path
      return
    end
  end
  def register_express_circle
    e_circle = ECircle.where(email: current_user.email)[0]
    Circle.create(user_id: current_user.id ,circle_genre_id: e_circle.circle_genre_id ,campus: e_circle.campus ,name: e_circle.name ,name_kana: e_circle.name_kana ,email: e_circle.email ,phone: e_circle.phone ,phone_possible: e_circle.phone_possible ,chief: e_circle.chief ,chief_kana: e_circle.chief_kana ,sub_chief: e_circle.sub_chief ,member_male: e_circle.member_male ,member_female: e_circle.member_female ,since: e_circle.since ,entrance_fee: e_circle.entrance_fee ,annual_fee: e_circle.annual_fee ,active_weeks: e_circle.active_weeks ,active_times: e_circle.active_times ,hangout: e_circle.hangout ,location: e_circle.location ,camp: e_circle.camp ,join_grades: e_circle.join_grades ,appeal: e_circle.appeal ,pr: e_circle.pr ,hp: e_circle.hp ,twitter: e_circle.twitter ,facebook: e_circle.facebook, status: 1)
    end
  end
  def user_registered_express?
    if user_signed_in?
      if current_user.circles.blank? && ECircle.where(email: current_user.email).present?
        register_express_circle
      end
    end
  end
end
