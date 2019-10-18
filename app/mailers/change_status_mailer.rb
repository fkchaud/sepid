class ChangeStatusMailer < ApplicationMailer
  def notify_change
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
