class FundsResolutionsController < ApplicationController
  before_action :set_funds_resolution,
                only: [:edit, :show, :update, :destroy]

  def index
    @funds_resolutions = FundsResolution.all
  end

  def create
    @funds_resolution = FundsResolution.new funds_resolution_params
    if @funds_resolution.save
      flash[:success] = 'Resolución cargada con éxito.'
      redirect_to @funds_resolution
    else
      render 'new'
    end
  end

  def new
    @funds_resolution = FundsResolution.new
  end

  def edit; end

  def show; end

  def update
    if @funds_resolution.update funds_resolution_params
      flash[:success] = 'Resolución actualizada con éxito.'
      redirect_to @funds_resolution
    else
      render 'edit'
    end
  end

  # can I destroy?
  def destroy; end

  private

  def set_funds_resolution
    @funds_resolution = FundsResolution.find params[:id]
  end

  def funds_resolution_params
    params.require(:funds_resolution)
          .permit(
            :number,
            :date,
            :resolution_type_id
          )
  end

end
