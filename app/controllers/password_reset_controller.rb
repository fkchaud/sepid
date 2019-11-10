class PasswordResetController < ApplicationController
  @@EXPIRATION_TIME_MINUTES = 60

  def index
    password_recovery_token = params[:tmp_token]
    @user = User.find_by(password_recovery_token: password_recovery_token)
    if @user
      time_difference_minutes = (Time.now - @user.password_recovery_expiration) / 60
      if time_difference_minutes < @@EXPIRATION_TIME_MINUTES
        @status = 1
        flash.now[:info] = 'Puedes cambiar tu contraseña'
      else
        @status = 2
        flash.now[:danger] = 'Ha expirado el tiempo para cambiar tu contraseña'
      end
    else
      @status = 3
      flash.now[:danger] = 'Solicitud invalida'
    end
  end

  def reset
    id = params[:id]
    @user = User.find id
    @status = 1
    time_difference_minutes = (Time.now - @user.password_recovery_expiration) / 60
    if time_difference_minutes < @@EXPIRATION_TIME_MINUTES
      new_password = params['user']['password']
      @user.password = new_password
      @user.password_recovery_token = nil
      @user.password_recovery_expiration = nil
      if params[:user][:password] != params[:user][:password_confirmation]
        flash.now[:warning] = 'Contraseña nueva no coincide con la confirmada'
        render 'password_reset/index'
      elsif params[:user][:password].length < 8 || params[:user][:password_confirmation].length < 8
        flash.now[:warning] = 'La contraseña debe ser mínimo de 8 caracteres'
        render 'password_reset/index'
      elsif params[:user][:password].length > 72 || params[:user][:password_confirmation].length > 72
        flash.now[:error] = 'La contraseña no debe superar los 72 caracteres'
        render 'password_reset/index'
      elsif @user.save
        flash.now[:success] = 'Contraseña modificada correctamente.'
        redirect_to welcome_index_path
      else
        flash.now[:danger] = 'Ocurrió un problema al cambiar la contraseña intenta de nuevo.'
        render 'password_reset/index'
      end
    else
      flash.now[:danger] = 'Ha expirado el tiempo para cambiar tu contraseña'
      redirect_to welcome_index_path
    end
  end
end
