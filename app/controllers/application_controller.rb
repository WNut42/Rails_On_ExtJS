class ApplicationController < ActionController::Base
#  protect_from_forgery


  def user_authorize
    puts session[:user_id].to_s+'-------------------'
    unless session[:user_id]
      redirect_to('/home/login') 
    end
  end

  def privilege_filter
    
  end

  def get_result info
    "{success:true,info:\"#{info}\"}"
  end

  def get_json count,json 
    "{totalProperty:#{count},root:#{json}}"
  end
end
