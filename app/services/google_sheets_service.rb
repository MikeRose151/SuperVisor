class GoogleSheetsService
  # Consider extracting rule logic into a separate RuleEvaluator or similar class once more rules are in place
  def self.new_client
    client = Google::Apis::SheetsV4::SheetsService.new
    client.authorization = GoogleAuthService.auth(scope: GoogleAuthService::SHEETS_READONLY_SCOPE)
    client.authorization.fetch_access_token!
    client
  end

  def self.check_for_blank_cells(spreadsheet_id, range)
    GoogleSheetsService.get_cell_values_count(spreadsheet_id, range) != SheetRangeTool.cell_count(range)
  end

  def self.get_cell_values_count(spreadsheet_id, range)
    client = GoogleSheetsService.new_client
    result = client.get_spreadsheet_values(spreadsheet_id, range) # spreadsheet_id = .google_file_id
    result.values.flatten.count
  end

  # TODO:
  # def self.fetch_sheet_names(spreadsheet)
  #   # TODO: Consider adjusting language as a sheet is technically each tab within a spreadsheet
  # end
end
