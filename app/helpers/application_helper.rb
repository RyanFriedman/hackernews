require('uri')
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
   
   def display_host(url)
     uri = URI::parse(url)
     if uri.host && uri.scheme
       uri.scheme = "generic"
       puts uri.host
       puts uri.host
       puts uri.host
       puts uri.host
       puts uri.host
       return uri.host
     end
     if uri.host
       return uri.host
     end
     uri
   end
   
   def host(url)
     uri = URI::parse(url)
     if uri.scheme.nil? && uri.host.nil?
       unless uri.path.nil?
         uri.scheme = "http"
         uri.host = uri.path
         uri.path = ""
       end
     end
     uri
   end
end
