class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: :dashboard
  before_action only: [:index, :show, :dashboard] do
    set_movie_list(params[:search])
  end

  def show
    @movies = Movie.user_movies(@user)

    @follows = @user.all_follows.map do |f|
      User.find_by(id: f.followable_id)
    end
  end

  def dashboard
    @user = current_user
    @follows = @user.all_follows.map do |f|
      User.find_by(id: f.followable_id)
    end
  end


  def follow
    current_user.follow(@user)
    redirect_to user_path(@user), notice: "now following #{@user.username}"
  end

  def unfollow
    current_user.stop_following(@user)
    redirect_to user_path(@user), alert: "unfollowed #{@user.username}"
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

end
