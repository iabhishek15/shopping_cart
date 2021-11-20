class Admin::SessionsController < ApplicationController
  def login
    if request.post?
      if params[:email] == "disturbance2.2@gmail.com" && params[:password] == "singh@98"
        session[:admin_logged_in] = true
        redirect_to home_path, notice: 'Admin logged in!'
      else
        flash[:alert] = "Invalid Email or password for Admin!"
        render :login
      end
    end
  end

  def logout
    if request.get?
      return redirect_to home_path
    end
    session[:admin_logged_in] = nil
    redirect_to admin_login_path
  end
end
