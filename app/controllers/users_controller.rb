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

  def update
    user = User.find(params[:id])
    authenticated_user = User.authenticate(user.email, params[:current_password])

    if authenticated_user.present?
      authenticated_user.update(user_params)
      flash[:notice] = "User successfully updated!"
      redirect_to edit_user_path(authenticated_user.id)
    else
      flash[:danger] = "Password did not match current user!"
      render :edit
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:token])
    if user.present?
      user.email_activate
      flash[:success] = "You have been confirmed, sign in!"
      redirect_to root_path
    else
      flash[:danger] = "User was not found!"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_salt,
      :password_hash,
      :auto_populate,
      :password_confirmation
    )
  end
end
