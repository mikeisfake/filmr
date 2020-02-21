class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  has_many :tags, through: :reviews
  has_many :movie_watchlists
  has_many :watchlists, through: :movie_watchlists

  validates :imdbid, presence: true

  accepts_nested_attributes_for :reviews

  scope :user_movies, -> (user) { joins(:reviews).where(reviews: { user: user})}

  def titleyear
    "#{self.title} (#{self.year})"
  end

  def render_poster
    img = self.poster
    str = "<img src='#{img}'>"
    str.html_safe
  end

  def genres
    self.genre.split(",")
  end

  def review_count
    self.reviews.count
  end

  def self.popular_this_week
    joins(:reviews).order(created_at: :desc).where(created_at: (Time.now.midnight - 1.week)..Time.now.midnight).group(:movie_id).having("COUNT(reviews.movie_id) > 1").order(:review_count)
  end

end
