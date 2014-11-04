module ApplicationHelper
  def active_link(current_page)
    return 'active' if request.original_fullpath.split('?').first == current_page
  end
  
  def resource_name
     :user
   end

   def resource
     @resource ||= User.new
   end

   def devise_mapping
     @devise_mapping ||= Devise.mappings[:user]
   end
   
   def strip_url_prefix(url)
     URI(url).to_s
            .gsub('http://www.',"")
            .gsub('http://',"")
            .gsub('https://www.',"")
            .gsub('https://',"")
   end
end
