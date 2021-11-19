class ApplicationController < ActionController::Base
  #TODO proper way of giving in the except as login can be more than one method
   before_action :is_authenticate_user!, except: [:login, :logout, :index]
   helper_method :admin_logged_in

   def admin_logged_in
     @admin_logged_in = session[:admin_logged_in]
   end

   def is_authenticate_user!(opts={})
     if admin_logged_in
       return true
     end
     opts[:scope] = :user
     warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
   end
end
