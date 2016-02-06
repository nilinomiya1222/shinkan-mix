class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_event_types

  def index
    @events = Event.all
  end
  def show
  end
  def search
    @events = Event.where(date: params[:date])
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end
  def set_event_types
    @event_types = EventType.all
  end
end
