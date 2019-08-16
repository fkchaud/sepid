class UserProfilesController < ApplicationController
  def create
    # solicita nombre usuario
    # solicita descripcion usuario
    @user_profile = UserProfile.new params[:user_profile]

    # buscar instancias de permisoacceso y mostrar en pantalla para seleccionar
    @access_permits = AccessPermit.all
    @access_permit
    # asigna nombre tipo usuario, descripcion tipo usuario
    # baja tipo usuario = null
    @user_profile.is_disabled = nil
    # guardar
    @user_profile.save  # returns true or folse si tuvo exito o no
    # informar exito
  end
end
