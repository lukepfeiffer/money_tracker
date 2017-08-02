class UsersController < ApplicationController

  expose :user
  expose :users do
    User.all
  end

  def new
    @hide_nav = true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now
      flash[:notice] = "Created succesfully, we sent you an email to confirm your account."
      redirect_to root_path
    else
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user.present?
      user.email_activate
      flash[:success] = "You have been confirmed, sign in!"
      redirect_to root_path
    else
      flash[:danger] = "User was not found!"
      redirect_to root_path
    end
  end


  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :password_salt,
      :password_hash
    )
  end
end
