class UserMailer < ActionMailer::Base
  default from: 'noreply.moneytracker@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Registration Confirmation")
  end
end
