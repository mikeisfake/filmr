class Tag < ApplicationRecord
  has_many :review_tags
  has_many :reviews, through: :review_tags
  has_many :movies, through: :reviews 

  validates :name, uniqueness: true
  validates :name, presence: true
end
