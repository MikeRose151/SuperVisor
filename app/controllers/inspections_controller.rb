class InspectionsController < ApplicationController
  def index
    @inspections = Inspection.all
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

  def inspection_params
    params.require(:inspection).permit(:title, :sheet_id, :status)
  end
end
