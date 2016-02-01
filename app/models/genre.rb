class Genre < ActiveRecord::Base
  belongs_to :lg_genre

# for genre list at index
  scope :academic, -> { where(lg_genre_id: 1) }
  scope :hobby, -> { where(lg_genre_id: 2) }
  scope :art, -> { where(lg_genre_id: 3) }
  scope :music, -> { where(lg_genre_id: 4) }
  scope :sports, -> { where(lg_genre_id: 5) }
  scope :others, -> { where(lg_genre_id: 6) }


  def genre_icon(genre)
    if genre == 'アカデミック'
      return 'education'
    elsif genre == '趣味'
      return 'send'
    elsif genre == '芸術'
      return 'picture'
    elsif genre == '音楽'
      return 'music'
    elsif genre == 'スポーツ'
      return 'fire'
    else
      return 'th-list'
    end
  end

  def genre_label(genre)
    if genre == 'アカデミック'
      return 'primary'
    elsif genre == '趣味'
      return 'success'
    elsif genre == '芸術'
      return 'info'
    elsif genre == '音楽'
      return 'warning'
    elsif genre == 'スポーツ'
      return 'danger'
    else
      return 'default'
    end
  end
end
