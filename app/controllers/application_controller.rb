class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search_api(string)
    HTTParty.get('http://www.omdbapi.com/?s=' + string + '&apikey=2cedcff3&')
  end

  def set_movie_list(result)
    @movie_list = []
    if !result['Error'] && !result.nil?
      @movie_list = result['Search'].compact.map do |m|
        Movie.new(title: m['Title'], year: m['Year'], poster: m['Poster'], imdbid: m['imdbID'])
      end
    else
      flash[:notice] = "No results bro"
    end
  end

  def return_api(string)
    HTTParty.get('http://www.omdbapi.com/?i=' + string + '&apikey=2cedcff3&').compact
  end

  protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
 end

end
