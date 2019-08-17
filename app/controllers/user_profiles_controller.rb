class UserProfilesController < ApplicationController
  def new; end

  def create
    # asigna name y description, obtenidos con el user_profile_params
    @user_profile = UserProfile.new user_profile_params

    # Buscar las instancias de AccessPermit seleccionadas.
    # El reject esta porque por alguna razon el checkbox devuelve
    # un miembro de la lista vacio y se pudre tod0
    @user_profile.access_permit_ids =
      access_permits_params[:access_permit_ids].reject(&:empty?)

    # baja tipo usuario = null
    # @user_profile.is_disabled = nil
    # eso lo hace por default el constructor si no le pasas,
    # asi que no hago nada

    # guardar
    @user_profile.save # returns true or folse si tuvo exito o no

    # informar exito se hace con el view: views/user_profiles/create.html.erb
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:name, :description)
  end

  def access_permits_params
    params.require(:user_profile).permit(access_permit_ids: [])
  end
end