class SheetsController < ApplicationController
  def index
    drive = Google::Apis::DriveV3::DriveService.new
    drive.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(Rails.root.join("config", "credentials", "google_service_account.json")),
      scope: "https://www.googleapis.com/auth/drive.readonly"
    )

    drive.authorization.fetch_access_token!

    @sheets = drive.list_files(
      q: "mimeType = 'application/vnd.google-apps.spreadsheet'",
      fields: "files(id, name, mimeType, owners, webViewLink)"
    )
  end

  def sync
  end
end
