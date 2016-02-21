class DateValidator < ActiveModel::Validator
  def validate(record)
    unless record.date >= EventTerm.in_term.start_date && record.date <= EventTerm.in_term.finish_date
      record.errors[:date] << '登録範囲外の日付は指定できません'
    end
  end
end

class Event < ActiveRecord::Base
  #association
  belongs_to :circle
  belongs_to :event_term
  belongs_to :event_type

  paginates_per 6

  #validation
  include ActiveModel::Validations
  validates_with DateValidator
  validates :date, presence: true
  validates :event_type_id, presence: true
  validates :fee, numericality: true
  validates :circle_id, presence: true
  validates :appeal, presence: true, length: { maximum: 100, too_long: '100字以内で入力してください'}
end

