class Inspection < ApplicationRecord
  belongs_to :sheet

  enum status: { active: 0, inactive: 1, archived: 2 }
  # active => Inspection is in use
  # inactive => Inspection is not in use (and its corresponding Sheet still exists)
  # archived => corresponding Sheet no longer exists (e.g. deleted from google drive, no longer shared with SuperVisor) but user wants to preserve Inspection

  validates :title, presence: true

  def blank_cells?
    GoogleSheetsService.check_for_blank_cells(sheet.google_file_id, range_to_check)
  end
end
