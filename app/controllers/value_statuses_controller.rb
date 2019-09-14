class ValueStatusesController < ApplicationController

  def index
    @value_statuses = ValueStatus.all
  end

  def create
    @value_status = ValueStatus.new value_status_params
    if @value_status.save
      flash[:success] = 'Estado de Valor creado con éxito.'
      redirect_to @value_status
    else
      render 'new'
    end
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
    if @value_status.update value_status_params
      flash[:success] = 'Proyecto actualizado con éxito.'
      redirect_to @value_status
    else
      render 'edit'
    end
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
