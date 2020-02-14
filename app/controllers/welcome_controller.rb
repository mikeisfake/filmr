class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      render 'users/dashboard'
    end
  end
end
