class PagesController < ApplicationController

  expose :user

  def home
    if current_user.present?
      redirect_to categories_path
    else
      redirect_to new_session_path
    end
  end

  def contact
    @hide_nav = true
  end

  def email_admin
    body = params[:user][:body]
    from = params[:user][:from]
    subject = params[:user][:subject]

    if from.present? && body.present?
      flash[:notice] = "Successfully sent email!"
      UserMailer.email_admin(from, body, subject).deliver_now
    else
      flash[:danger] = "Something went wrong..."
    end

    redirect_to contact_path
  end

  private

  def permitted_params
    params.require(:user).permit(
      :from,
      :body,
      :subject
    )
  end
end
