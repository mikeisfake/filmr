module UsersHelper

  def all_follow_reviews(follows, num)
    follows.map do |user|
      user.reviews
    end.flatten.sample(num)
  end

  def mutuals?(user)
    user.following?(current_user) && user.followed_by?(current_user)
  end

end
