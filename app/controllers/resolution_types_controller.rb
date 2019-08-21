class ResolutionTypesController < ApplicationController

  def index
    @resolution_types = ResolutionType.all
  end

  def create
    @resolution_type = ResolutionType.new resolution_type_params
    render 'new' unless @resolution_type.save
  end

  def new
    @resolution_type = ResolutionType.new
  end

  def edit
    @resolution_type = ResolutionType.find params[:id]
  end

  def show
    @resolution_type = ResolutionType.find params[:id]
  end

  def update
    @resolution_type = ResolutionType.find params[:id]
    render 'edit' unless @resolution_type.update resolution_type_params
  end

  def destroy
    @resolution_type = ResolutionType.find params[:id]
    @resolution_type.update is_disabled: Time.now
    redirect_to resolution_types_path
  end

  private

  def resolution_type_params
    params.require(:resolution_type).permit(:name, :description)
  end

end
