module SearchHelper

  def this_page
    if current_page?(dashboard_path)
      dashboard_path
    end
  end

end
