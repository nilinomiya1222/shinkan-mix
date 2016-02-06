class Like < ActiveRecord::Base

  #Association
  belongs_to :circle
  belongs_to :user
end
