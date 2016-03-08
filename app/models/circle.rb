class EmailValidator < ActiveModel::Validator
  def validate(record)
    unless record.show_email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[:email] << 'の形式が正しくありません'
    end
  end
end
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
  has_many :rules, through: :circle_points
  has_many :appeals, through: :circle_points
  has_many :likes

  #enum
  enum status: %i(closed registered published)

  #validatrion
  include ActiveModel::Validations
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :circle_genre_id, presence: true
  validates :join_grades, presence: true
  validates :pr, length: { maximum: 25, too_long: 'PRは２５字以内で入力してください'}
  validates_with EmailValidator
  validates_with PhoneNumberValidator

  paginates_per 6

  #scope
    #for search
      scope :name_like, -> name { where('name like ?', "%#{name}%") if name.present? }
      scope :genre_like, -> all_member { where("all_member > 100") if name.present? }

  def return_grade
    if self == 0
      return '新１年'
    elsif self == 1
      return '新１・２年'
    elsif self == 2
      return '新１〜３年'
    elsif self == 3
      return '新１〜４年'
    elsif self == 4
      return '新１〜４年・院生'
    elsif self == 5
      return '新１〜４年・院生・社会人'
    elsif self == 6
      return '新２・３年'
    elsif self == 7
      return '新２〜４年'
    elsif self == 8
      return '新１〜８年'
    elsif self == 9
      return '新１〜８年・院生'
    elsif self == 10
      return '新１〜５年'
    elsif self == 11
      return '新１〜６年'
    elsif self == 12
      return '新１〜６年・院生'
    elsif self == 13
      return '新１〜６年・社会人'
    elsif self == 14
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
