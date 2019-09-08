class SubsectionShiftsController < ApplicationController
  before_action :set_projects,
                only: [:index, :new, :create, :show]

  def index
    @subsection_shifts = SubsectionShift.from_project(@project)
  end

  def show
    @subsection_shift = SubsectionShift.find params[:id]
  end

  def new
    @subsection_shift = SubsectionShift.new
    Subsection.enabled.each do |subsection|
      @subsection_shift
        .project_funds_details
        .build(
          year: Time.now.year,
          subsection: subsection,
          project: @project
        )
    end
  end

  def create
    @subsection_shift = SubsectionShift.new subsection_shift_params
    @subsection_shift.requested_date = Time.now
    SubsectionShiftStatusHistory.create(
      date: Time.now,
      subsection_shift: @subsection_shift,
      subsection_shift_status: SubsectionShiftStatus.enabled.find_by_name('Solicitado')
    )
    if @subsection_shift.save
      redirect_to project_subsection_shifts_url
    else
      render 'new'
    end
  end

  def approve
    @subsection_shift = SubsectionShift.find params[:id]
    if @subsection_shift.valid?
      SubsectionShiftStatusHistory.create(
        date: Time.now,
        subsection_shift_id: params[:id],
        subsection_shift_status: SubsectionShiftStatus.find_by_name('Aprobado')
      )
      redirect_to project_subsection_shifts_url
    else
      set_projects
      flash.now[:error] = 'Invalid Subsection Shift'
      render 'show'
    end
  end

  def reject
    SubsectionShiftStatusHistory.create(
      date: Time.now,
      subsection_shift_id: params[:id],
      subsection_shift_status: SubsectionShiftStatus.find_by_name('Rechazado')
    )
    # flash
    redirect_to project_subsection_shifts_url
  end

  private

  def subsection_shift_params
    params
      .require(:subsection_shift)
      .permit(
        :requested_cause,
        project_funds_details_attributes: [
          :funds_amount,
          :year,
          :subsection_id,
          :project_id
        ]
      )
  end

  def set_projects
    @project = Project.find params[:project_id]
    @total_credits = @project.total_credits
    @total_expenses = @project.total_expenses
    @available_credits = @project.available_credits @total_credits, @total_expenses
  end

end
