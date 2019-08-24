class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to welcome_index_path
    else
      #Acá falta poner que muestre un mensaje de error
      render 'new'
    end
  end

  def destroy
  end
end
