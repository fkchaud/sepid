class ValueStatusesController < ApplicationController

  def index
    @value_statuses = ValueStatus.all
  end

  def create
    @value_status = ValueStatus.new value_status_params
    render 'new' unless @value_status.save
  end

  def new
    @value_status = ValueStatus.new
  end

  def edit
    @value_status = ValueStatus.find params[:id]
  end

  def show
    @value_status = ValueStatus.find params[:id]
  end

  def update
    @value_status = ValueStatus.find params[:id]
    render 'edit' unless @value_status.update value_status_params
  end

  def destroy
    @value_status = ValueStatus.find params[:id]
    @value_status.update is_disabled: Time.now
    redirect_to value_statuses_path
  end

  private

  def value_status_params
    params.require(:value_status).permit(:value_status_name)
  end

end
