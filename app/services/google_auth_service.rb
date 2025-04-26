class GoogleAuthService
  DRIVE_READONLY_SCOPE = "https://www.googleapis.com/auth/drive.readonly"
  SHEETS_READONLY_SCOPE = "https://www.googleapis.com/auth/spreadsheets.readonly"

  def self.auth(scope:)
    Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(Rails.root.join("config", "credentials", "google_service_account.json")),
      scope: scope
    )
  end
end
