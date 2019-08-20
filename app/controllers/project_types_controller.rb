class ProjectTypesController < ApplicationController

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
    params.require(:project_type).permit(:name, :purpose, :function, :program, :activity, :financing)
  end

end
