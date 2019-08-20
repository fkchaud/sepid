class ProjectTypesController < ApplicationController

  PURPOUSE = { 'Seleccione' => 0,
               '03 - Servicios Sociales' => 3 }.freeze
  FUNCTION = { '05 - Ciencia y Técnica' => 5 }.freeze
  PROGRAM = { '18 - Investigación' => 18 }.freeze
  ACTIVITY = { '02 - Investigación Aplicada' => 2 }.freeze
  FINANCING = { '11 - Contribución del Tesoro' => 11 }.freeze

  def index
    @project_types = ProjectType.all
  end

  def create
    @project_type = ProjectType.new project_type_params
    render 'new' unless @project_type.save
  end

  def new
    @project_type = ProjectType.new
  end

  def edit
    @project_type = ProjectType.find params[:id]
  end

  def show
    @project_type = ProjectType.find params[:id]
  end

  def update
    @project_type = ProjectType.find params[:id]
    render 'edit' unless @project_type.update project_type_params
  end

  def destroy
    @project_type = ProjectType.find params[:id]
    @project_type.update is_disabled: Time.now
    redirect_to project_types_path
  end

  private

  def project_type_params
    params.require(:project_type)
          .permit(:name, :purpose, :function, :program, :activity, :financing)
  end

end
