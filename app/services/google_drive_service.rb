class GoogleDriveService
  def self.fetch_spreadsheets
    google_drive_client = Google::Apis::DriveV3::DriveService.new
    google_drive_client.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(Rails.root.join("config", "credentials", "google_service_account.json")),
      scope: "https://www.googleapis.com/auth/drive.readonly"
    )

    google_drive_client.authorization.fetch_access_token!

    @sheets = google_drive_client.list_files(
      q: "mimeType = 'application/vnd.google-apps.spreadsheet'",
      fields: "files(id, name, mimeType, owners, webViewLink)"
    )
  end
end