class UserMailer < ApplicationMailer
def welcome_email(user)
    @user = user
    mail(to: 'shivamd@shriffle.com', subject: 'Welcome to My Awesome Site')
  end
end


UserMailer.welcome_email(User.last)
