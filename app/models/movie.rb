class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  has_many :watchlists, through: :movie_watchlists

  validates :imdbid, presence: true

  accepts_nested_attributes_for :reviews

  scope :user_movies, -> (user) { joins(:reviews).where(reviews: { user: user})}

  def titleyear
    "#{self.title} (#{self.year})"
  end

  def render_poster
    img = self.poster
    str = "<img src='"+ img +"'>"
    str.html_safe
  end

  def genres
    self.genre.split(",")
  end

  def review_count
    self.reviews.count
  end

  # def self.new_this_week
  #   order(created_at: :desc).where(created_at: (Time.now.midnight - 1.week)..Time.now.midnight).joins(:reviews).where("reviews > ?", 0)
  # end

end
