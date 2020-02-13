class Users::UsersController < ApplicationController

  def show
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
            m['Poster'] = 'https://66.media.tumblr.com/5a186c216ce45dbc68730be8ced57a06/e872194058456955-3c/s400x600/68cd75aef527634109c5573a4ef945941dc451b2.png'
          end
          Movie.new(title: m['Title'], year: m['Year'], poster: m['Poster'], imdbid: m['imdbID'])
        end
      else
        flash[:notice] = "No results bro"
      end
    end
    render :dashboard
  end

end
