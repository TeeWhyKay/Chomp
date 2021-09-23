class UserMailer < ApplicationMailer
  def welcome
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: "You've created a Chomp account")
    # This will render a view in `app/views/user_mailer`!
  end
end
