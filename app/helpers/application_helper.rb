module ApplicationHelper
    private
  
    def user_signed_in?
      session[:user_id].present?
    end
    
  end
  