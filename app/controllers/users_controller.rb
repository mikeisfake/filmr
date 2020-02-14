class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @movies = Movie.user_movies(@user)
  end

  def dashboard
    @movie = Movie.new
    if params[:search]
      @movie_list = []
      movie = params[:search]
      query = search_api(movie)
      if !query['Search'].nil?
        @movie_list = query['Search'].compact.map do |m|
          if m['Poster']== 'N/A'
            m['Poster'] = 'app/assets/images/no-cover.png'
          end
          Movie.new(title: m['Title'], year: m['Year'], poster: m['Poster'], imdbid: m['imdbID'])
        end
      else
        flash[:notice] = "No results bro"
      end
    end
    render :dashboard
  end

  def follow
  end

end
