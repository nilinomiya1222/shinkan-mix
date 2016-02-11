class GenresController < ApplicationController
  def show
    @genre = genre_class.find(params[:id])
    if type == 'CircleGenre'
      @contents = @genre.circle.where.not(status: "closed").page(params[:page])
    else
      @contents = @genre.events.order("date ASC").page(params[:page])
    end
  end

  private
  #for STI methods(event_type, circle_genres)
  def type
    params[:type]
  end
  def genre_class
    type.constantize
  end
end
