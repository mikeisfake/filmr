class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[github], authentication_keys: %i[username]

  validates :username, uniqueness: true
  validates :username, :password, presence: true
  validates :password, length: {in: 6..24}

  has_many :reviews
  has_many :movies, through: :reviews

  acts_as_follower
  acts_as_followable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.username = auth.info.nickname
    user.password = Devise.friendly_token[0, 20]
    #user.image = auth.info.image
    end
  end
end
