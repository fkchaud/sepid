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

  def destroy; end

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
            :activity_type
          )
  end

end
