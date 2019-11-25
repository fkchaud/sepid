class FundsResolutionsController < ApplicationController
  before_action :set_funds_resolution,
                only: [:edit, :show, :update, :destroy]

  DAYS_TO_EDIT = 7

  def index
    @funds_resolutions = FundsResolution.all
    @funds_resolutions.each do |fr|
      fr.is_editable = (Time.now - fr.created_at) / 86_400 <= DAYS_TO_EDIT
    end
  end

  def create
    @funds_resolution = FundsResolution.new funds_resolution_params
    if @funds_resolution.save
      flash.now[:success] = 'Resolución cargada con éxito.'
      redirect_to @funds_resolution
    else
      render 'new'
    end
  end

  def new
    @funds_resolution = FundsResolution.new
  end

  def edit
    @is_editable = (Time.now - @funds_resolution.created_at) / 86_400 <= DAYS_TO_EDIT
    unless @is_editable
      flash[:danger] = "Ha pasado el límite de #{DAYS_TO_EDIT} días para editar o eliminar."
      redirect_to funds_resolutions_path
    end
  end

  def show
    @is_editable = false
  end

  def update
    if @funds_resolution.update funds_resolution_params
      flash[:success] = 'Resolución actualizada con éxito.'
      redirect_to @funds_resolution
    else
      render 'edit'
    end
  end

  def destroy
    funds_resolution = FundsResolution.find(params[:id])
    is_destroyable = (Time.now - funds_resolution.created_at) / 86_400 <= DAYS_TO_EDIT
    if is_destroyable
      funds_resolution.funds_destinations.each { |fd| fd.project_funds_details.destroy_all }
      funds_resolution.funds_destinations.destroy_all
      @funds_resolution.destroy
    else
      flash[:danger] = "Ha pasado el límite de #{DAYS_TO_EDIT} días para editar o eliminar."
    end
    redirect_to funds_resolutions_path
  end

  private

  def set_funds_resolution
    @funds_resolution = FundsResolution.find(params[:id])
    @funds_destinations = @funds_resolution.funds_destinations.map do |fd|
      {
        data: fd,
        project_funds_details: fd.project_funds_details
                                 .select(:subsection_id)
                                 .group(:subsection_id)
                                 .sum(:funds_amount),
        projects: fd.project_funds_details.map { |pfd| pfd.project }.flatten.uniq
      }
    end
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
