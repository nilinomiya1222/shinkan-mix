class EventTerm < ActiveRecord::Base

  #Association
  has_many :events

  scope :in_term, -> { where(status: 1)[0] }
end
