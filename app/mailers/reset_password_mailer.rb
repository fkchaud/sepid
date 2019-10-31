class ResetPasswordMailer < ApplicationMailer
  def reset_request(user, base_url)
    @user = user
    @recovery_url = "#{base_url}/password_reset/#{@user.password_recovery_token}"
    mail(to: @user.email, subject: 'Solicitud de cambio de contraseña')
  end
end
