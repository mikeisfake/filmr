module UsersHelper

  def all_follow_reviews(follows, num)
    follows.map do |user|
      user.reviews
    end.flatten.sample(num)
  end

end
