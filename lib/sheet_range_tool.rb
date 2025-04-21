# TODO: convert this into a gem
class SheetRangeTool
  def self.cell_count(range)
    # SheetRangeTool.cell_count("A1:D2")       # => 8
    # Assume range is formatted like "F4:H8" as opposed to "Sheet1!A10:Sheet1!B20" (user of the gem can manipulate their data if needed)
    # Handle if it's a backwards range (e.g. A5:B2, B2:A5, B5:A2)
    first_cell, last_cell = range.split(":")
    first_cell_letters, first_cell_numbers = cell_to_row_and_column(first_cell)
    last_cell_letters, last_cell_numbers = cell_to_row_and_column(last_cell)
    num_columns = (column_letters_to_number(last_cell_letters) - column_letters_to_number(first_cell_letters)).abs + 1
    num_rows = (last_cell_numbers.to_i - first_cell_numbers.to_i).abs + 1
    cell_count = num_rows * num_columns
  end

  # SheetRangeTool.dimensions("B2:D5")       # => { rows: 4, cols: 3 }
  # SheetRangeTool.expand("C1:D2")           # => ["C1", "C2", "D1", "D2"]
  # SheetRangeTool.col_to_index("Z")         # => 25
  # SheetRangeTool.index_to_col(27)          # => "AB"
  # RangeHelper.to_indices("A1")             # => { row: 0, col: 0 }

  class << self
    private
    
    def cell_to_row_and_column(cell)
      cell.upcase.scan(/([A-Z]+)(\d+)/).flatten
    end

    def column_letters_to_number(letters)
      letters.upcase.chars.reduce(0) { |sum, char| sum * 26 + (char.ord - 'A'.ord + 1) }
    end
  end
end
