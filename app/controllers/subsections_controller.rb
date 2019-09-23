class SubsectionsController < ApplicationController

  def index
    @subsections = Subsection.all
  end

  def create
    @subsection = Subsection.new subsection_params
    if @subsection.save
      flash[:success] = 'Inciso creado con éxito.'
      redirect_to @subsection
    else
      render 'new'
    end
  end

  def new
    @subsection = Subsection.new
  end

  def edit
    @subsection = Subsection.find params[:id]
  end

  def show
    @subsection = Subsection.find params[:id]
  end

  def update
    @subsection = Subsection.find params[:id]
    if @subsection.update subsection_params
      flash[:success] = 'Inciso actualizado con éxito.'
      redirect_to @subsection
    else
      render 'edit'
    end

  end

  def destroy
    @subsection = Subsection.find params[:id]
    @subsection.update is_disabled: Time.now
    redirect_to subsections_path
  end

  private

  def subsection_params
    params.require(:subsection).permit(:name, :description)
  end

end
