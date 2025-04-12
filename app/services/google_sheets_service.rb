class GoogleSheetsService
# Consider extracting rule logic into a separate RuleEvaluator or similar class once more rules are in place
  def self.get_cell_values(spreadsheet_id, range)
    client = GoogleSheetsService.new_client
    result = client.get_spreadsheet_values(spreadsheet_id, range) # spreadsheet_id = .google_file_id
    result.values # returns a 2D array structure (grid)
  end

  def self.new_client
    client = Google::Apis::SheetsV4::SheetsService.new
    client.authorization = GoogleAuthService.auth(scope: GoogleAuthService::SHEETS_READONLY_SCOPE)
    client.authorization.fetch_access_token!
    client
  end

  def self.fetch_sheet_names(spreadsheet)
    # TODO: Consider adjusting language as a sheet is technically each tab within a spreadsheet
  end
end