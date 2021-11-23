class ApplicationController < ActionController::Base
  #TODO proper way of giving in the except as login can be more than one method
   before_action :is_authenticate_user!, except: [:login, :logout, :index, :shop]
   before_action :card_count
   helper_method :admin_logged_in, :super_user_logged_in

   def admin_logged_in
     @admin_logged_in = session[:admin_logged_in]
   end

   def super_user_logged_in
     @super_user_logged_in = session[:super_user_logged_in]
   end

   def card_count
     if current_user
       @cart_count = User.find(current_user.id).orders.length
     end
  end

   def is_authenticate_user!(opts={})
     if admin_logged_in
       return true
     end
     opts[:scope] = :user
     warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
   end
end
