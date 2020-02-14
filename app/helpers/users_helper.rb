module UsersHelper
  def your_page
    current_user.id == params[:id]
  end
end
