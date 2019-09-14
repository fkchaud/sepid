class UserProfilesController < ApplicationController

  def index
    @user_profiles = UserProfile.all
  end

  def create
    @user_profile = UserProfile.new user_profile_params
    @user_profile.access_permit_ids = access_permits_ids
    if @user_profile.save
      flash[:success] = 'Perfil de Usuario creado con éxito.'
      redirect_to @user_profile
    else
      render 'new'
    end
  end

  def new
    @user_profile = UserProfile.new
  end

  def edit
    @user_profile = UserProfile.find params[:id]
  end

  def show
    @user_profile = UserProfile.find params[:id]
  end

  def update
    @user_profile = UserProfile.find params[:id]
    @user_profile.access_permit_ids = access_permits_ids
    if @user_profile.update user_profile_params
      flash[:success] = 'Perfil de Usuario actualizado con éxito.'
      redirect_to @user_profile
    else
      render 'edit'
    end
  end

  def destroy
    @user_profile = UserProfile.find(params[:id])
    @user_profile.update(is_disabled: Time.now)
    redirect_to user_profiles_path
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:name, :description)
  end

  def access_permits_ids
    params
      .require(:user_profile)
      .permit(access_permit_ids: [])[:access_permit_ids]
      .reject(&:empty?)
  end

end