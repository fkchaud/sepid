class SubsectionShiftStatusesController < ApplicationController

  def index
    @subsection_shift_statuses = SubsectionShiftStatus.all
  end

  def create
    @subsection_shift_status =
      SubsectionShiftStatus.new subsection_shift_status_params
    render 'new' unless @subsection_shift_status.save
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
    render 'edit' unless
      @subsection_shift_status.update subsection_shift_status_params
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
