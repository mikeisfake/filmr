class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_follows

  def show
    @movies = Movie.user_movies(@user)
  end

  def dashboard
    @popular = Movie.popular_this_week
  end


  def follow
    if @user == current_user
      flash[:alert] = "you're great and all but you can't follow yourself"
    elsif @user.followed_by?(current_user)
      flash[:alert] = "you're already following #{@user.username}"
    else
      current_user.follow(@user)
      flash[:notice] = "now following #{@user.username}"
    end
    redirect_to user_path(@user)
  end

  def unfollow
    current_user.stop_following(@user)
    redirect_to user_path(@user), alert: "unfollowed #{@user.username}"
  end

  def followers
  end

  def following
  end


  private

  def set_user
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def set_follows
    @following = @user.all_following
    @followers = @user.followers
  end

end
