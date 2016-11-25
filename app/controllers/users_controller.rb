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
      redirect_to categories_path
    else
      redirect_to :root
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
