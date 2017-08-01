class SessionsController < ApplicationController
  def new
    @hide_nav = true
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to categories_path
    else
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
