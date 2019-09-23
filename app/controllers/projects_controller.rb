class ProjectsController < ApplicationController
  before_action :set_projects,
                only: [:edit, :show]

  def index
    if current_user.user_profile.name == 'Investigador'
      @projects = Project.where(director_id: current_user.id).or(Project.where(codirector_id: current_user.id))
    else
      # if current_user.user_profile.name == 'Super_Admin'
      @projects = Project.all
    end
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = 'Proyecto creado con éxito.'
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find params[:id]
    if @project.update project_params
      flash[:success] = 'Proyecto actualizado con éxito.'
      redirect_to @project
    else
      render 'edit'
    end
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

  def set_projects
    @project = Project.find params[:id]
    @total_credits = @project.total_credits
    @total_expenses = @project.total_expenses
    @available_credits = @project.available_credits @total_credits, @total_expenses
  end

end
