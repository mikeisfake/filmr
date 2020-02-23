class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[github], authentication_keys: %i[username]

  has_many :reviews, dependent: :destroy
  has_many :movies, through: :reviews
  belongs_to :watchlist, optional: true 

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true, on: :create
  validates :password, length: {in: 6..24}, on: :create
  validates :bio, length: {maximum: 500}
  validates :tagline, length: {maximum: 30}

  acts_as_follower
  acts_as_followable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.username = auth.info.nickname
    user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.recent_movies
    joins(:movies).sort_by{|t| - t.created_at.to_i}.first(5)
  end

  def render_bio
    self.bio.gsub("\r\n\r", '<br>').gsub("\r\n", '<br>').gsub("\n", '<br>').html_safe
  end

  def new_from_following
    self.all_following.map do |friend|
      friend_movies = []
      friend_movies << friend.movies.map {|movie| movie}.sort_by {|m| m.created_at}
    end.reject { |e| e.empty?}.flatten.uniq
  end

end
