class Circle < ActiveRecord::Base

  #association
  belongs_to :user
  belongs_to :circle_genre
  has_many :events
  has_many :circle_points
  has_many :rules, through: :circle_points
  has_many :appeals, through: :circle_points

  #enum
  enum status: %i(closed published)

  #validatrion
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :circle_genre_id, presence: true
  validates :join_grades, presence: true
  validates :pr, length: { maximum: 25, too_long: 'PRは２５字以内で入力してください'}


  #scope
    #for search
      scope :name_like, -> name { where('name like ?', "%#{name}%") if name.present? }
      scope :genre_like, -> all_member { where("all_member > 100") if name.present? }
      scope :major_like, -> all_member { where("all_member > 100") if name.present? }

  def all_member
    member_male.to_i + member_female.to_i
  end

  def lg_genre_name
    circle_genre.lg_genre.name
  end

end
