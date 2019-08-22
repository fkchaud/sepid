class UsersController < ApplicationController

  def index
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

    # if logged_user.user_profile.name == 'SuperUser'
    @user_profiles = UserProfile.enabled
    # elsif logged_user.user_profile.name == 'SCyT_Admin'
    #   user_profiles =
    # end
    @university_positions = UniversityPosition.enabled
    render 'new'
  end

  def new
    # if logged_user.user_profile.name == 'SuperUser'
    @user_profiles = UserProfile.enabled
    # elsif logged_user.user_profile.name == 'SCyT_Admin'
    #   user_profiles =
    # end
    @user = User.new
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
