class SubsectionShiftsController < ApplicationController
  before_action :set_projects,
                only: [:new, :create]

  def index
    @project = Project.find params[:project_id]
    @subsection_shifts = SubsectionShift.from_project(@project)
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
      render plain: params.inspect
    else
      render 'new'
    end
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
