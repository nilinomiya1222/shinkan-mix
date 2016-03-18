class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    unless record.phone =~ /^0[0-9]{1,4}-[0-9]{1,4}-[0-9]{4}$/
      record.errors[:phone] << ' 電話番号の形式が正しくありません'
    end
  end
end

class Circle < ActiveRecord::Base
  #association
  belongs_to :user
  belongs_to :circle_genre
  has_many :events
  has_many :circle_points
  has_many :likes
  belongs_to :e_circle

  #enum
  enum status: %i(closed registered published)

  #validatrion
  include ActiveModel::Validations
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :circle_genre_id, presence: true
  validates :join_grades, presence: true
  validates :pr, length: { maximum: 32, too_long: 'PRは２５字以内で入力してください'}
  validates_with PhoneNumberValidator

  paginates_per 6

  #scope
    #for search
      scope :name_like, -> name { where('name like ?', "%#{name}%") if name.present? }
      scope :genre_like, -> all_member { where("all_member > 100") if name.present? }

  def return_grade
    grade = self.join_grades
    if grade == 0
      return '新１年'
    elsif grade == 1
      return '新１・２年'
    elsif grade == 2
      return '新１〜３年'
    elsif grade == 3
      return '新１〜４年'
    elsif grade == 4
      return '新１〜４年・院生'
    elsif grade == 5
      return '新１〜４年・院生・社会人'
    elsif grade == 6
      return '新２・３年'
    elsif grade == 7
      return '新２〜４年'
    elsif grade == 8
      return '新１〜８年'
    elsif grade == 9
      return '新１〜８年・院生'
    elsif grade == 10
      return '新１〜５年'
    elsif grade == 11
      return '新１〜６年'
    elsif grade == 12
      return '新１〜６年・院生'
    elsif grade == 13
      return '新１〜６年・社会人'
    elsif grade == 14
      return '指定なし'
    else
      return '５年以上'
    end
  end


  def all_member
    member_male.to_i + member_female.to_i
  end

  def lg_genre_name
    circle_genre.lg_genre.name
  end

  def like_blank?(current_user)
    likes.find_by(user_id: current_user.id).blank? unless current_user.blank?
  end
end
