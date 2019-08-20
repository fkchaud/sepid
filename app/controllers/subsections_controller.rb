class SubsectionsController < ApplicationController

  def index
    @subsections = Subsection.all
  end

  def create
    @subsection = Subsection.new subsection_params
    render 'new' unless @subsection.save
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
    render 'edit' unless @subsection.update subsection_params
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
