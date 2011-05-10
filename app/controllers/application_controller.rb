class ApplicationController < ActionController::Base
  protect_from_forgery


  def user_authorize
    redirect_to('/home/login') if session[:user_id] == nil
  end

  def privilege_filter
    
  end

  def get_json info
    "{success:true,info:\"#{info}\"}"
  end
end
