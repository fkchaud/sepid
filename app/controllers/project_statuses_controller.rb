class ProjectStatusesController < ApplicationController
  
  def index
    @project_statuses = ProjectStatus.all
  end

  def create
    @project_status = ProjectStatus.new project_status_params
    render 'new' unless @project_status.save
  end

  def new
    @project_status = ProjectStatus.new
  end

  def edit
    @project_status = ProjectStatus.find params[:id]
  end

  def show
    @project_status = ProjectStatus.find params[:id]
  end

  def update
    @project_status = ProjectStatus.find params[:id]
    render 'edit' unless @project_status.update project_status_params
  end

  def destroy
    @project_status = ProjectStatus.find params[:id]
    @project_status.update is_disabled: Time.now
    redirect_to project_statuses_path
  end

  private

  def project_status_params
    params.require(:project_status).permit(:name, :description)
  end

end
