class InspectionsController < ApplicationController
  def index
    @inspections = Inspection.order(:title)
  end

  def new
    @inspection = Inspection.new
    @sheets = Sheet.all
  end

  def create
    @inspection = Inspection.new(inspection_params)
    if @inspection.save
      redirect_to inspections_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def toggle_active
    @inspection = Inspection.find(params[:id])
    @inspection.active? ? @inspection.inactive! : @inspection.active!
    redirect_to inspections_path
  end

  def destroy
    @inspection = Inspection.find(params[:id])
    @inspection.destroy
    redirect_to inspections_path
  end

  private

  def inspection_params
    params.require(:inspection).permit(:title, :sheet_id, :range_to_check, :status)
  end
end
