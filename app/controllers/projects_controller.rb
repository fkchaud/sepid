class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find params[:id]
  end

  def create
    @project = Project.new project_params
    return if @project.save

    render 'new'
  end

  def update
    @project = Project.find params[:id]
    return if @project.update project_params

    render 'edit'
  end

  def destroy
    @project = Project.find params[:id]
    @project.update project_status: ProjectStatus.find_by_name('Cancelado')
    redirect_to projects_path
  end

  def self.project_status_to_select(project)
    if project.id.nil? # if new
      ProjectStatus.enabled.where(name: 'Aprobado')
    else # if update
      # no puede cancelar, y tienen que ser estados que no esten deshabilitados
      ProjectStatus.enabled.where.not(name: 'Cancelado')
                   .or(ProjectStatus.where(id: project.project_status.id))
      # pero hay que agregarle el estado actual, este deshabilitado o sea Cancelado
    end
  end

  private

  def project_params
    params.require(:project)
          .permit(
            :project_code,
            :project_name,
            :project_description,
            :start_date,
            :ending_date,
            :technological_scientific_unit,
            :project_program,
            :activity_type,
            :director_id,
            :codirector_id,
            :project_type_id,
            :project_status_id
          )
  end

end
