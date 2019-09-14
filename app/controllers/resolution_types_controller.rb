class ResolutionTypesController < ApplicationController

  def index
    @resolution_types = ResolutionType.all
  end

  def create
    @resolution_type = ResolutionType.new resolution_type_params
    if @resolution_type.save
      flash[:success] = 'Tipo de Resolución creado con éxito.'
      redirect_to @resolution_type
    else
      render 'new'
    end
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
    if @resolution_type.update resolution_type_params
      flash[:success] = 'Tipo de Resolución actualizado con éxito.'
      redirect_to @resolution_type
    else
      render 'edit'
    end
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
