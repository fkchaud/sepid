class UsersController < ApplicationController

  def index
    if current_user.user_profile.name == 'Super_Admin'
      user_profiles = UserProfile.all
    elsif current_user.user_profile.name == 'SeCYT_Admin'
      user_profiles = UserProfile.where(name: 'Investigador')
    else
      render 'layouts/forbidden', status: :forbidden
      return
    end
    @users = User.profile(user_profiles)
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Usuario creado con éxito.'
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def show
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update user_params
      flash[:success] = 'Usuario actualizado con éxito.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.update is_disabled: Time.now
    redirect_to users_path
  end

  def user_profiles
    if current_user.user_profile.name == 'Super_Admin'
      UserProfile.enabled
    elsif current_user.user_profile.name == 'SeCYT_Admin'
      UserProfile.enabled.where(name: 'Investigador')
    else
      render 'layouts/forbidden', status: :forbidden
    end
  end

  def change_password
  end

  def change_password_continue
   # render plain: params[:user].inspect
    if current_user.authenticate(params[:user][:current_password])
      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:error] = "Contraseña nueva no coincide con la confirmada"
        redirect_to change_password_path
        return
      end
      if params[:user][:password].length < 8 || params[:user][:password_confirmation].length < 8
        flash[:error] = "La contraseña debe ser mínimo de 8 caracteres"
        redirect_to change_password_path
        return
      end
      if params[:user][:password].length > 72 || params[:user][:password_confirmation].length > 72
        flash[:error] = "La contraseña debe ser máximo de 72 caracteres"
        redirect_to change_password_path
        return
      end
      if current_user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        flash[:success] = "Contraseña cambiada con éxito"
        redirect_to users_path
        return
      end
    else
      flash[:error] = "Contraseña incorrecta"
    end
     redirect_to change_password_path
     return
  end

  def password_reset
    @user = User.find_by(user_name: params[:user][:user_name])
    if @user
      password_recovery_token = SecureRandom.hex(32)
      @user.password_recovery_token = password_recovery_token
      @user.password_recovery_expiration = Time.now
      begin
        @user.save!
        base_url = request.protocol + request.host_with_port
        ResetPasswordMailer.reset_request(@user, base_url).deliver_later
        render json: {success: 'request reset password successful'}, status: :ok
      rescue Exception => e
        render json: {error: 'Fail save user with temporal password recovery token'}, status: :internal_server_error
      end
    else
      render json: {error: 'User not found'}, status: :not_found
    end
  end
  def forget_password
  end

  private

  def user_params
    params.require(:user)
          .permit(:user_name, :password, :file_number,
                  :last_name, :first_name, :email,
                  :telephone, :cuil, :user_profile_id,
                  :university_position_id)
  end

end
