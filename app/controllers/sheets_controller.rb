class SheetsController < ApplicationController
  def index
    @sheets = GoogleDriveService.fetch_spreadsheets
  end

  def sync
  end
end
