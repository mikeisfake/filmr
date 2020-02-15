class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: :dashboard

  def show
    @movies = Movie.user_movies(@user)
    @movie = Movie.new
    set_movie_list params[:search] if params[:search]
  end

  def dashboard
    @user = current_user
    @follows = @user.all_follows.map do |f|
      User.find_by(id: f.followable_id)
    end
  end

  def follow
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def unfollow
    current_user.stop_following(@user)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
