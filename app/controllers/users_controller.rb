class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @movies = Movie.user_movies(@user)
  end

  def dashboard
    @movie = Movie.new
    if params[:search]
      result = search_api(params[:search])
      set_movie_list(result)
    end
    render :dashboard
  end

  def follow
  end

end
