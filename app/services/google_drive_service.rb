class GoogleDriveService
  def self.fetch_spreadsheets
    client = Google::Apis::DriveV3::DriveService.new
    # TODO: move the following logic to a service as it's shared with google sheets
    client.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(Rails.root.join("config", "credentials", "google_service_account.json")),
      scope: "https://www.googleapis.com/auth/drive.readonly"
    )

    @sheets = client.list_files(
      q: "mimeType = 'application/vnd.google-apps.spreadsheet'",
      fields: "files(id, name, mimeType, owners, webViewLink)"
    )
  end
end