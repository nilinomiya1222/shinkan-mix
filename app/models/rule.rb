class Rule < Point
  has_many :circle_points
  has_many :circles, through: :circle_points
end
