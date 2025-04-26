class GoogleDriveService
  def self.new_client
    client = Google::Apis::DriveV3::DriveService.new
    client.authorization = GoogleAuthService.auth(scope: GoogleAuthService::DRIVE_READONLY_SCOPE)
    client.authorization.fetch_access_token! # TODO: check if this line is necessary
    client
  end

  def self.fetch_spreadsheets
    client = new_client

    @sheets = client.list_files(
      q: "mimeType = 'application/vnd.google-apps.spreadsheet'",
      fields: "files(id, name, mimeType, owners, webViewLink)"
    )
  end
end
