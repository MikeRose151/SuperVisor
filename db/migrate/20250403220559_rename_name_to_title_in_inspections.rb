class RenameNameToTitleInInspections < ActiveRecord::Migration[8.0]
  def change
    rename_column :inspections, :name, :title
  end
end
