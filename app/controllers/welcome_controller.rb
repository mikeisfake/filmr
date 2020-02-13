class WelcomeController < ApplicationController
  def home
    if user_signed_in?
      render 'movies/index'
    end
  end
end
