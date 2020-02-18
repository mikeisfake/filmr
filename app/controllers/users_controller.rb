class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_follows

  def show
    @movies = Movie.user_movies(@user)
  end

  def dashboard
  end


  def follow
    current_user.follow(@user)
    redirect_to user_path(@user), notice: "now following #{@user.username}"
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
