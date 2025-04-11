class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all
  end

  def sync_with_drive
    files = GoogleDriveService.fetch_spreadsheets.files

    files.each do |file|
      Sheet.find_or_initialize_by(google_file_id: file.id).tap do |sheet|
        sheet.name = file.name
        sheet.url = file.web_view_link
        sheet.owner_emails = file.owners.map(&:email_address)
        sheet.save!
      end
    end

    redirect_to sheets_path, notice: "Sheets fetched and saved successfully."
  end
end
