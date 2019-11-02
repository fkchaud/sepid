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
    @status = 1
    time_difference_minutes = (Time.now - @user.password_recovery_expiration) / 60
    if time_difference_minutes < @@EXPIRATION_TIME_MINUTES
      new_password = params['user']['password']
      @user.password = new_password
      @user.password_recovery_token = nil
      @user.password_recovery_expiration = nil
      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:error] = "Contraseña nueva no coincide con la confirmada"
        render 'password_reset/index'
        return
      end
      if params[:user][:password].length < 8 || params[:user][:password_confirmation].length < 8
        flash[:error] = "La contraseña debe ser mínimo de 8 caracteres"
        render 'password_reset/index'
        return
      end
      if params[:user][:password].length > 72 || params[:user][:password_confirmation].length > 72
        flash[:error] = "La contraseña debe ser máximo de 72 caracteres"
        render 'password_reset/index'
        return
      end
      if @user.save!
        flash[:success] = "Contraseña modificada correctamente."
        redirect_to welcome_index_path
        return
      else
        flash[:danger] = "Ocurrió un problema al cambiar la contraseña intenta de nuevo."
        render 'password_reset/index'
        return
      end
    else
      flash[:danger] = "Ha expirado el tiempo para cambiar tu contraseña"
      redirect_to welcome_index_path
      return
    end
  end
end
