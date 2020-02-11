tags = %w(fantasy action thriller classic spy)

tags.each do |tag|
  Tag.create(name: tag)
end
