class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @movies = Movie.user_movies(@user)
  end

  def dashboard
    @movie = Movie.new
    set_movie_list params[:search] if params[:search]
    render :dashboard
  end

  def follow
  end

end
