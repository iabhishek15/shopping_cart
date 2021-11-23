class Admin::SessionsController < ApplicationController
  def login
    if request.post?
      super_user_email = ENV["SUPER_USER_EMAIL"]
      super_user_password = ENV["SUPER_USER_PASSWORD"]
      @admin = Admin.find_by_email(params[:email])
      if params[:email] == super_user_email && params[:password] == super_user_password
        session[:super_user_logged_in] = true
        session[:admin_logged_in] = true
        redirect_to home_path, notice: 'Super User logged in!'
      elsif @admin && @admin.authenticate(params[:password])
        session[:admin_logged_in] = true
        redirect_to home_path, notice: 'Admin logged in!'
      else
        flash[:alert] = "Invalid Email or password for Admin!"
        render :login
      end
    end
  end

  def signup
    @admin = Admin.new
    if request.post?
      user_params = params.require(:admin).permit(:email, :password, :password_confirmation)
      @admin = Admin.new(user_params)
      if @admin.save
        redirect_to home_path, notice: "New Admin has been added!"
      end
    end
  end

  def logout
    if request.get?
      return redirect_to home_path
    end
    session[:admin_logged_in] = nil
    session[:super_user_logged_in] = nil
    redirect_to admin_login_path
  end
end
