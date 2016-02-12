class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #association
  has_many :circles
  has_many :likes

  #enum
  enum status: %i(general owner admin)

  #validation
  validates :nickname, presence: true
  validate :rule_confirmed_valid?

  private
  def rule_confirmed_valid?
    errors.add(:rule_confirmed, 'して頂かない場合は、登録できません。') unless rule_confirmed == true
  end
end
