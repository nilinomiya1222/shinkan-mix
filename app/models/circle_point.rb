class CirclePoint < ActiveRecord::Base
  belongs_to :circle
  belongs_to :rule
  belongs_to :appeal
end
