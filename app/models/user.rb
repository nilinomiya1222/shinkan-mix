class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #association
  has_many :circles

  #enum
  enum status: %i(general owner admin)

  #validation
  validates :nickname, presence: true
end
