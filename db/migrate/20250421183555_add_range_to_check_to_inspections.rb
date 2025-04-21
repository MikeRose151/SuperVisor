class AddRangeToCheckToInspections < ActiveRecord::Migration[7.1]
  def change
    add_column :inspections, :range_to_check, :string
  end
end
