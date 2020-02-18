class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :review_tags
  has_many :tags, through: :review_tags

  validates :content, presence: true
  validates :movie, presence: true

  accepts_nested_attributes_for :tags

  def render_content
    self.content.gsub("\r\n\r", '<br>').gsub("\r\n", '<br>').gsub("\n", '<br>').html_safe
  end

  def render_date
    self.created_at.strftime("%d.%m.%Y")
  end

  def tag_name=(names)
    tags = names.split(',').map do |n|
      n = n.strip
      Tag.find_or_create_by(name: n)
    end
    self.tags << (tags)
  end

  def tag_name
    if self.tags
      self.tags.map do |tag|
        "#{tag.name},"
      end
    end
  end

  def owns?(user)
    self.user == user
  end

end
