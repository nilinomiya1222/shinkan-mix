class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_event_types
  before_action :user_has_circle? , only: [:new, :create, :edit, :update, :destroy]
  before_action :circle_owner?, only: [:new, :create, :edit, :update]
  before_action :registerable_term?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @events = Event.order('date ASC').page(params[:page])
  end

  def show
  end

  def new
    @event = Event.new
    @event.date = Date.today
  end

  def create
    if current_user.owner?
      @event = Event.new(event_params)
      if @event.save
        flash[:success] = 'イベント情報が投稿されました'
        redirect_to event_path(@event)
      else
        render :new
        flash[:error] = '投稿に失敗しました'
      end
    end
  end

  def edit
  end

  def update
    if @event.circle.user_id == current_user.id
      if @event.update(event_params)
        redirect_to event_path(@event)
        flash[:success] = 'イベント情報が更新されました'
      else
        render :edit, danger: 'イベント情報の更新に失敗しました'
      end
    end
  end

  def destroy
    if @event.circle.user_id == current_user.id
      if @event.destroy
        flash[:success] = 'イベント情報を削除しました'
        redirect_to events_path
      else
        flash[:danger] = 'イベント情報の削除に失敗しました'
        redirect_to events_path
      end
    end
  end

  def search
    @events = Event.where(date: params[:date])
  end

  def send_mail
    st_id = params[:circle][:st_id].to_i
    fn_id = params[:circle][:fn_id].to_i
    if current_user.admin?
      if st_id > fn_id
        redirect_to :show, notice: '始まりと終わりの数値が逆のようです。'
      else
        while st_id <= fn_id do
          ConfirmMailer.sendmail_event(st_id).deliver
          st_id += 1
        end
        redirect_to user_path(id: current_user.id)
      end
    end
  end

  private
  def event_params
    params.require(:event).permit(:date, :meeting_place, :meeting_time, :fee, :place, :appeal, :circle_id, :event_type_id).merge(event_term_id: EventTerm.in_term.id)
  end
  def circle_owner?
    unless current_user.owner?
      redirect_to circles_path and return
    end
  end
  def set_event
    @event = Event.find(params[:id])
  end
  def set_event_types
    @event_types = EventType.all
  end
  def user_has_circle?
    if current_user.circles.blank?
      redirect_to new_circle_path
    end
  end
  def registerable_term?
    if EventTerm.where(status: 1).blank?
      redirect_to events_path
      flash[:warning] = '登録可能期間外です'
    end
  end
end
