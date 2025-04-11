class AddSheetRefToInspections < ActiveRecord::Migration[7.1]
  def change
    add_reference :inspections, :sheet, null: false, foreign_key: true
  end
end
