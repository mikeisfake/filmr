class TagsController < ApplicationController
  before_action only: [:index, :show] do
    set_movie_list(params[:search])
  end
  
  def show
    @tag = Tag.find_by(id: params[:id])
  end
end
