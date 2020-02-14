class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_movie_list(string)
    result = HTTParty.get("http://www.omdbapi.com/?s=#{string}&apikey=2cedcff3&")
    @movie_list = []
    if !result['Error'] && !result.nil?
      @movie_list = result['Search'].compact.map do |m|
        Movie.new(
          title: m['Title'],
          year: m['Year'],
          poster: m['Poster'],
          imdbid: m['imdbID']
        )
      end
    else
      flash[:notice] = "No results bro"
    end
  end

  def set_movie(string)
    result = HTTParty.get("http://www.omdbapi.com/?i=#{string}&apikey=2cedcff3&").compact
    @movie = Movie.new(
      title: result['Title'],
      year: result['Year'],
      genre: result['Genre'],
      director: result['Director'],
      poster: result['Poster'],
      plot: result['Plot'],
      imdbid: result['imdbID']
    )
  end

  def find_or_create_movie(query)
    if @movie = Movie.find_by(imdbid: query)
      redirect_to @movie
    elsif set_movie(query).save
      redirect_to @movie
    else
      flash[:notice] = "Invalid entry"
      @movies = Movie.all
      render :index
    end
  end

  protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
 end

end
