module ApplicationHelper
  def active_link(current_page)
    return 'active' if request.original_fullpath.split('?').first == current_page
  end
end
