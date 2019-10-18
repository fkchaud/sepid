class ChangeStatusMailer < ApplicationMailer
  def notify_change
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Cambio de estado')
  end
end
