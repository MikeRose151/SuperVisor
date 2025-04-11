class InspectionsController < ApplicationController
  def index
    @inspections = Inspection.all
  end

  def new
    @inspection = Inspection.new
    @sheets_selection = Sheet.all.map { |sheet| "#{sheet.name} (#{sheet.google_file_id[0..7]}...)"}
  end

  def create
    @inspection = Inspection.new(user_params)
    if @inspection.save
      redirect_to inspections_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def user_params
    params.expect(inspection: [:title, :sheet_url_string, :active])
  end
end
