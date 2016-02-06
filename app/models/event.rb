class Event < ActiveRecord::Base
  #association
  belongs_to :circle
  belongs_to :event_term
  belongs_to :event_type

end

