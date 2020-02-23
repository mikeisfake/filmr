class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action do
    set_movie_list(params[:search])
  end

  def set_movie_list(string)
    result = HTTParty.get("http://www.omdbapi.com/?s=#{string}&apikey=2cedcff3&")
    @movie_list = []
    if !result['Error'] && !result.nil?
      @movie_list = result['Search'].compact.map do |m|
        poster = m['Poster'] == 'N/A' ? 'https://66.media.tumblr.com/5a186c216ce45dbc68730be8ced57a06/29fe15eaade870e6-a7/s400x600/1c5884a55da0a8d151061ab122fbd715e201f7b9.png' : m['Poster']
        Movie.new(
          title: m['Title'],
          year: m['Year'],
          poster: poster,
          imdbid: m['imdbID']
        )
      end
    elsif result['Error'] == "Movie not found!"
      flash[:alert] = "no results"
    end
  end

  def set_movie(string)
    result = HTTParty.get("http://www.omdbapi.com/?i=#{string}&apikey=2cedcff3&").compact
    dir = result['Director'] == 'N/A' ? result['Writer'] : result['Director']
    poster = result['Poster'] == 'N/A' ? 'https://66.media.tumblr.com/5a186c216ce45dbc68730be8ced57a06/29fe15eaade870e6-a7/s400x600/1c5884a55da0a8d151061ab122fbd715e201f7b9.png' : result['Poster']
    @movie = Movie.new(
      title: result['Title'],
      year: result['Year'],
      genre: result['Genre'],
      director: dir,
      poster: poster,
      plot: result['Plot'],
      imdbid: result['imdbID']
    )
  end

  def find_or_create_movie(query)
    if @movie = Movie.find_by(imdbid: query)
      redirect_to @movie
    elsif set_movie(query).save
      redirect_to @movie
    end
  end

  def update_or_create_watchlist
    if current_user.watchlist.nil?
      @watchlist = Watchlist.new
      current_user.watchlist = @watchlist
      @watchlist.movies << @movie
      if @watchlist.save
        flash[:notice] = "movie added to watchlist"
        return redirect_to movie_path(@movie)
      end
    elsif !current_user.watchlist.movies.include?(@movie)
      current_user.watchlist.movies << @movie
      flash[:notice] = "movie added to watchlist"
      return redirect_to movie_path(@movie)
    else
      redirect_to movie_path(@movie)
    end
  end

  protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:bio, :username, :tagline])

   devise_parameter_sanitizer.permit(:account_update, keys: [:bio, :username, :tagline])
 end

end
