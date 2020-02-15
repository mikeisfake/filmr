class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

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

  # def self.user_movies(user)
  #   joins(:reviews).where(reviews: { user: user } )
  # end

end
