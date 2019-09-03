class SubsectionShiftsController < ApplicationController

  def new
    @project = Project.find params[:project_id]
    @total_credits = get_total_credits @project
    @total_expenses = get_total_expenses @project
    @available_credits = get_available_credits @total_credits, @total_expenses
  end

  private

  def get_total_credits(project)
    project_funds_details = project.project_funds_details.where year: Time.now.year
    total_credits_per_subsection = {}
    total_credits_per_subsection.default = 0
    project_funds_details.each do |pfd|
      total_credits_per_subsection[pfd.subsection] += pfd.funds_amount
    end
    total_credits_per_subsection
  end

  def get_total_expenses(project)
    orders = project.orders.where('extract(year from order_date) = ?', Time.now.year)
    valid_orders = orders.reject do |o|
      ['Cancelado', 'Rechazado'].include? o.order_status.order_status_name
    end
    order_details = valid_orders.order_details
    total_expenses_per_subsection = {}
    total_expenses_per_subsection.default = 0
    order_details.each do |od|
      total_expenses_per_subsection[od.subsection] += od.last_value.amount
    end
    total_expenses_per_subsection
  end

  def get_available_credits(credits, expenses)
    available_credits_per_subsection = {}
    credits.each_key { |key| available_credits_per_subsection[key] = credits[key] - expenses[key] }
    available_credits_per_subsection
  end

end
