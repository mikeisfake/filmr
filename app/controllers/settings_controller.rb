class SettingsController < ApplicationController

  def edit
    @settings = Setting.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
    byebug
  end

  def update
  end
end
