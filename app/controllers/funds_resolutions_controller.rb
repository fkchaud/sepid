class FundsResolutionsController < ApplicationController
  before_action :set_funds_resolution,
                only: [:edit, :show, :update, :destroy]

  def index
    @funds_resolutions = FundsResolution.all
  end

  def create
    @funds_resolution = FundsResolution.new funds_resolution_params
    render 'new' unless @funds_resolution.save
  end

  def new
    @funds_resolution = FundsResolution.new
  end

  def edit; end

  def show; end

  def update
    render 'edit' unless @funds_resolution.update funds_resolution_params
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
            funds_destinations_attributes: [:id, :name]
          )
  end

end
