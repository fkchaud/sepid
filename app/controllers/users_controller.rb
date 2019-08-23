class UsersController < ApplicationController

  def index
    # TODO: implement for SuperUser vs SCyT_Admin user
    # if logged_user.user_profile.name == 'SuperUser'
    user_profiles = UserProfile.all
    # elsif logged_user.user_profile.name == 'SCyT_Admin'
    #   user_profiles =
    # end
    @users = User.profile(user_profiles)
  end

  def create
    @user = User.new user_params
    return if @user.save

    render 'new'
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
    return if @user.update user_params

    render 'edit'
  end

  def destroy
    @user = User.find params[:id]
    @user.update is_disabled: Time.now
    redirect_to users_path
  end

  def self.user_profiles
    # TODO: implement for SuperUser vs SCyT_Admin user
    # if logged_user.user_profile.name == 'SuperUser'
    user_profiles = UserProfile.enabled
    # elsif logged_user.user_profile.name == 'SCyT_Admin'
    #   user_profiles = UserProfile.enabled.where(name: 'Investigador')
    # end
    user_profiles
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
