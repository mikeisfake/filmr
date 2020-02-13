class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :search_api

  def search_api(string)
    HTTParty.get('http://www.omdbapi.com/?s=' + string + '&apikey=2cedcff3&')
  end

  def return_api(string)
    HTTParty.get('http://www.omdbapi.com/?i=' + string + '&apikey=2cedcff3&').compact
  end

  protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
 end

 private

 def after_sign_in_path_for(resource_or_scope)
    movies_path
  end

end
