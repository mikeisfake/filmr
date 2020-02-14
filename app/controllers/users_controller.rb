class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :dashboard]

  def show
    @movies = Movie.user_movies(@user)
    @following = current_user.following_users.map do |u|
      u.username
    end
    byebug
    @movie = Movie.new
    set_movie_list params[:search] if params[:search]
  end

  def dashboard
    @movie = Movie.new
    set_movie_list params[:search] if params[:search]
  end

  def follow
    @user = User.find_by(params[:user_id])
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def unfollow
    @user = User.find_by(params[:user_id])
    current_user.stop_following(@user)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
