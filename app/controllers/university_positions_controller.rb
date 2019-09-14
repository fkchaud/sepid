class UniversityPositionsController < ApplicationController

  def index
    @university_positions = UniversityPosition.all
  end

  def create
    @university_position = UniversityPosition.new university_position_params
    if @university_position.save
      flash[:success] = 'Cargo Universitario creado con éxito.'
      redirect_to @university_position
    else
      render 'new'
    end
  end

  def new
    @university_position = UniversityPosition.new
  end

  def edit
    @university_position = UniversityPosition.find params[:id]
  end

  def show
    @university_position = UniversityPosition.find params[:id]
  end

  def update
    @university_position = UniversityPosition.find params[:id]
    if @university_position.update university_position_params
      flash[:success] = 'Proyecto actualizado con éxito.'
      redirect_to @university_position
    else
      render 'edit'
    end

  end

  def destroy
    @university_position = UniversityPosition.find params[:id]
    @university_position.update is_disabled: Time.now
    redirect_to university_positions_path
  end

  private

  def university_position_params
    params.require(:university_position)
          .permit(:name, :per_travel_payment, :per_lunch_payment)
  end

end
