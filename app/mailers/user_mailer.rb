class UserMailer < ActionMailer::Base
  default from: 'noreply.moneytracker@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Registration Confirmation")
  end

  def email_admin(from, body, subject)
    @body = body
    mail(to: ENV['ADMIN_EMAIL'], subject: subject, from: from)
  end
end
