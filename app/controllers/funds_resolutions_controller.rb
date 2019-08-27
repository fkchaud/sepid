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
    # TODO: pfd year can't be blank must be number
    # TODO: pfd subsection must exist (no, it doesn't need to)
    # TODO: pfd project must exist
    # TODO: uncomment :resolution_type_id
    params.require(:funds_resolution)
          .permit(
            :number,
            :date,
            # :resolution_type_id,    comentado para que explote a proposito
            funds_destinations_attributes: [
              :id,
              :name,
              project_funds_details_attributes: [
                :id,
                :funds_amount,
                :subsection_id
              ]
            ]
          )
  end

end
