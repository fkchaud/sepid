class FundsDestinationsController < ApplicationController

  def new
    @funds_resolution = FundsResolution.find params[:funds_resolution_id]
    @funds_destination = FundsDestination.new
    Subsection.enabled.each do |subsection|
      @funds_destination.project_funds_details.build(subsection: subsection)
    end
  end

  def create
    # nuevo Destino Fondos con nombre y
    # detalle_fondo_proyecto con monto e inciso setteado
    @funds_destination = FundsDestination.new funds_destination_params
    # busca y settea la resolucion
    # ademas, sin esto no anda el "cancel"
    @funds_resolution = FundsResolution.find params[:funds_resolution_id]
    @funds_destination.funds_resolution = @funds_resolution
    @funds_destination.project_funds_details = distribute_among_proyects
    if @funds_destination.save
      redirect_to @funds_resolution
      return
    end

    Subsection.enabled.each do |subsection|
      amount = @funds_destination
               .project_funds_details
               .select { |pfd| pfd.subsection == subsection }
               .sum { |pfd| pfd.funds_amount }
      @funds_destination.project_funds_details.build(subsection: subsection, funds_amount: amount)
    end
    @funds_destination.project_funds_details = @funds_destination.project_funds_details[-3..-1]
    render 'new'
  end

  private

  def funds_destination_params
    params.require(:funds_destination)
          .permit(
            :name,
            project_id: [],
            project_funds_details_attributes: [
              :funds_amount,
              :subsection_id
            ]
          )
  end

  def distribute_among_proyects
    projects = @funds_destination.project_id.reject(&:empty?)
    projects_count = projects.length
    pfds = []
    @funds_destination.project_funds_details.each do |pfd|
      projects.each do |project_id|
        pfd_new = ProjectFundsDetail.new
        pfd_new.funds_amount = (pfd.funds_amount || 0) / projects_count
        pfd_new.year = Time.now.year
        pfd_new.subsection_id = pfd.subsection_id
        pfd_new.funds_destination_id = pfd.funds_destination_id
        pfd_new.project_id = project_id
        pfds << pfd_new
      end
    end
    pfds
  end

end
