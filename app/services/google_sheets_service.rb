class GoogleSheetsService
  # Consider extracting rule logic into a separate RuleEvaluator or similar class once more rules are in place
  def self.new_client
    client = Google::Apis::SheetsV4::SheetsService.new
    client.authorization = GoogleAuthService.auth(scope: GoogleAuthService::SHEETS_READONLY_SCOPE)
    client.authorization.fetch_access_token!
    client
  end

  def self.range_contains_blanks?(spreadsheet_id, range)
    GoogleSheetsService.count_non_blank_cells(spreadsheet_id, range) != SheetRangeTool.cell_count(range) ? true : false
  end

  def self.count_non_blank_cells(spreadsheet_id, range)
    client = GoogleSheetsService.new_client
    result = client.get_spreadsheet_values(spreadsheet_id, range) # spreadsheet_id = .google_file_id
    Array(result.values).flatten.reject(&:blank?).count
  end

  # TODO:
  # def self.fetch_sheet_names(spreadsheet)
  #   # Consider adjusting language as a sheet is technically each tab within a spreadsheet
  # end
end
