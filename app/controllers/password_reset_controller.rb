class PasswordResetController < ApplicationController
  @@EXPIRATION_TIME_MINUTES = 10
  def index
    password_recovery_token = params[:tmp_token]
    @user = User.find_by(password_recovery_token: password_recovery_token)
    if @user
      time_difference_minutes = (Time.now - @user.password_recovery_expiration) / 60
      if time_difference_minutes < @@EXPIRATION_TIME_MINUTES
        @status = 1
        flash[:info] = "Puedes cambiar tu contraseña"
      else
        @status = 2
        flash[:danger] = "Ha expirado el tiempo para cambiar tu contraseña"
      end
    else
      @status = 3
      flash[:danger] = "Solicitud invalida"
    end
  end

  def reset
    email = params[:email]
    @user = User.find_by(email: email)
    time_difference_minutes = (Time.now - @user.password_recovery_expiration) / 60
    if time_difference_minutes < @@EXPIRATION_TIME_MINUTES
      new_password = params['user']['password']
      @user.password = new_password
      @user.password_recovery_token = nil
      @user.password_recovery_expiration = nil
      if @user.save!
        flash[:success] = "Contraseña modificada correctamente."
      else
        flash[:danger] = "Ocurrió un problema al cambiar la contraseña intenta de nuevo."
      end
    else
      flash[:danger] = "Ha expirado el tiempo para cambiar tu contraseña"
    end
  end
end
