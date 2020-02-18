class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
