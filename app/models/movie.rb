class Movie < ApplicationRecord
  has_many :reviews

  validates :imdbid, presence: true

  accepts_nested_attributes_for :reviews

  def titleyear
    "#{self.title}, (#{self.year})"
  end
end
