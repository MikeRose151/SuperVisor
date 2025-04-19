class GoogleDriveService
  def self.fetch_spreadsheets
    client = Google::Apis::DriveV3::DriveService.new
    client.authorization = GoogleAuthService.auth(scope: GoogleAuthService::DRIVE_READONLY_SCOPE)

    @sheets = client.list_files(
      q: "mimeType = 'application/vnd.google-apps.spreadsheet'",
      fields: "files(id, name, mimeType, owners, webViewLink)"
    )
  end
end