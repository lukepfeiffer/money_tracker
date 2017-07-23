class UsersController < ApplicationController

  expose :user
  expose :users do
    User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      redirect_to root_path(notice: "Created succesfully, please sign in!")
    else
      redirect_to :new
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_salt,
      :password_hash
    )
  end
end
