class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[github], authentication_keys: %i[username]

  has_many :reviews, dependent: :destroy
  has_many :movies, through: :reviews

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true, on: :create
  validates :password, length: {in: 6..24}, on: :create
  validates :bio, length: {maximum: 500}
  validates :tagline, length: {maximum: 30}

  validates_uniqueness_of :user_id, scope: :movies

  acts_as_follower
  acts_as_followable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.username = auth.info.nickname
    user.password = Devise.friendly_token[0, 20]
    #user.image = auth.info.image
    end
  end

  def self.recent_movies
    joins(:movies).sort_by{|t| - t.created_at.to_i}.first(5)
  end

  def render_bio
    self.bio.gsub("\r\n\r", '<br>').gsub("\r\n", '<br>').gsub("\n", '<br>').html_safe
  end




end
