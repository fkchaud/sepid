class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to welcome_index_path
    end
  end

  def create
    user = User.enabled.find_by(user_name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      unless user.is_disabled.nil?
        flash[:error] = 'Usuario no habilitado, comuníquese con el administrador del sistema'
        redirect_to login_path
        return
      end
      log_in user
      redirect_to welcome_index_path
    else
      flash.now[:error] = 'Nombre de usuario y/o contraseña incorrectos'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
