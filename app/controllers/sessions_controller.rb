class SessionsController < ApplicationController
  def new
    @hide_nav = true
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.present? && user.confirmed_email?
      session[:user_id] = user.id
      flash[:success] = "Sign in successful!"
      redirect_to categories_path(notice: "Sign in successful")
    elsif user.present?
      flash[:danger] = "User has not been confirmed yet!"
      redirect_to root_path
    else
      flash[:danger] = "Email or password did not match"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
