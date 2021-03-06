class SubsectionShiftStatusesController < ApplicationController

  def index
    @subsection_shift_statuses = SubsectionShiftStatus.all
  end

  def create
    @subsection_shift_status =
      SubsectionShiftStatus.new subsection_shift_status_params

    if @subsection_shift_status.save
      flash[:success] = 'Estado de Cambio de Inciso creado con éxito.'
      redirect_to @subsection_shift_status
    else
      render 'new'
    end
  end

  def new
    @subsection_shift_status = SubsectionShiftStatus.new
  end

  def edit
    @subsection_shift_status = SubsectionShiftStatus.find params[:id]
  end

  def show
    @subsection_shift_status = SubsectionShiftStatus.find params[:id]
  end

  def update
    @subsection_shift_status = SubsectionShiftStatus.find params[:id]
    if @subsection_shift_status.update subsection_shift_status_params
      flash[:success] = 'Estado de Cambio de Inciso actualizado con éxito.'
      redirect_to @subsection_shift_status
    else
      render 'edit'
    end
  end

  def destroy
    @subsection_shift_status = SubsectionShiftStatus.find params[:id]
    @subsection_shift_status.update is_disabled: Time.now
    redirect_to subsection_shift_statuses_path
  end

  private

  def subsection_shift_status_params
    params.require(:subsection_shift_status).permit(:name, :description)
  end

end
