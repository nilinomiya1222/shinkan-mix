class GenresController < ApplicationController
  def show
    @genre = genre_class.find(params[:id])
    if type == 'CircleGenre'
      @contents = @genre.circle
    else
      @contents = @genre.events
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
