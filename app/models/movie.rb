class Movie < ApplicationRecord
  has_many :reviews

  validates :imdbid, presence: true

  accepts_nested_attributes_for :reviews

  def titleyear
    "#{self.title}, (#{self.year})"
  end

  def render_poster
    img = self.poster
    str = "<img src='"+ img +"'>"
    str.html_safe
  end
end
