class FundsDestinationsController < ApplicationController

  def new
    @funds_resolution = FundsResolution.find params[:funds_resolution_id]
    @funds_destination = FundsDestination.new
    Subsection.enabled.each do |subsection|
      @funds_destination.project_funds_details.build(subsection: subsection)
    end

    @subsection_funds_details = Subsection.enabled.map do |subsection|
      ProjectFundsDetail.new(
        funds_amount: 0.0,
        subsection: subsection
      )
    end
  end

  def create
    # nuevo Destino Fondos con nombre y
    # detalle_fondo_proyecto con monto e inciso setteado
    @funds_destination = FundsDestination.new funds_destination_params
    @subsection_funds_details = []
    subsection_funds_params[:subsection_funds_details_attributes].each do |_k, sfd|
      pfd = ProjectFundsDetail.new(sfd)
      pfd.funds_destination = @funds_destination
      @subsection_funds_details << pfd
    end
    # busca y settea la resolucion
    # ademas, sin esto no anda el "cancel"
    @funds_resolution = FundsResolution.find params[:funds_resolution_id]
    @funds_destination.funds_resolution = @funds_resolution
    @funds_destination.project_funds_details = distribute_among_proyects
    if @funds_destination.save
      redirect_to @funds_resolution
      return
    end

    render 'new'
  end

  def edit
    @funds_resolution = FundsResolution.find params[:funds_resolution_id]
    @funds_destination = FundsDestination.find(params[:id])
    @funds_destination.project_id = @funds_destination.project_funds_details.map(&:project_id).uniq

    Subsection.enabled.each do |subsection|
      amount = (@funds_destination
               .project_funds_details
               .select { |pfd| pfd.subsection == subsection }
               .sum(&:funds_amount) / 100.0).round * 100
      @funds_destination.project_funds_details.build(subsection: subsection, funds_amount: amount)
    end

    @subsection_funds_details = @funds_destination.project_funds_details[-3..-1]
  end

  def update
    # nuevo Destino Fondos con nombre y
    # detalle_fondo_proyecto con monto e inciso setteado
    @funds_destination = FundsDestination.find params[:id]
    @funds_destination.attributes = funds_destination_params
    @subsection_funds_details = []
    subsection_funds_params[:subsection_funds_details_attributes].each do |_k, sfd|
      pfd = ProjectFundsDetail.new(sfd)
      pfd.funds_destination = @funds_destination
      @subsection_funds_details << pfd
    end
    # busca y settea la resolucion
    # ademas, sin esto no anda el "cancel"
    @funds_resolution = FundsResolution.find params[:funds_resolution_id]

    if @subsection_funds_details.any? { |sfd| sfd.funds_amount <= 0 }
      @funds_destination.errors.add :subsection_funds_details, 'must be positive'
      render 'edit'
      return
    end

    @funds_destination.project_funds_details = distribute_among_proyects
    if @funds_destination.save
      clean_unused_pfd
      redirect_to @funds_resolution
      return
    end

    render 'edit'
  end

  private

  def funds_destination_params
    params.require(:funds_destination)
          .permit(
            :name,
            project_id: []
          )
  end

  def subsection_funds_params
    params.require(:funds_destination)
          .permit(
            subsection_funds_details_attributes: [
              :funds_amount,
              :subsection_id
            ]
          )
  end

  def distribute_among_proyects
    projects = @funds_destination.project_id.reject(&:empty?)
    projects_count = projects.length
    pfds = []
    @subsection_funds_details.each do |sfd|
      projects.each do |project_id|
        pfd_new = ProjectFundsDetail.new
        pfd_new.funds_amount = (sfd.funds_amount || 0) / projects_count
        pfd_new.year = Time.now.year
        pfd_new.subsection_id = sfd.subsection_id
        pfd_new.funds_destination_id = sfd.funds_destination_id
        pfd_new.project_id = project_id
        pfds << pfd_new
      end
    end
    pfds
  end

  def clean_unused_pfd
    ProjectFundsDetail.where(funds_destination: nil, subsection_shift: nil).destroy_all
  end

end
