class UserMailer < ApplicationMailer
  def welcome
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Welcome to Chomp!')
    # This will render a view in `app/views/user_mailer/welcome.html.erb`!
  end
end
