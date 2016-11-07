class UsersController < ApplicationController
  expose :user
  expose :users do
    User.all
  end

  def new
  end

  def create
    require 'pry'; binding.pry;
    @user = User.new(user_params)
    if @user.save
      redirect_to :root
    else
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password_salt,
      :password_hash
    )
  end
end
