class Movie < ApplicationRecord
  has_many :reviews

  accepts_nested_attributes_for :reviews

  def titleyear
    "#{self.title}, (#{self.year})"
  end
end
