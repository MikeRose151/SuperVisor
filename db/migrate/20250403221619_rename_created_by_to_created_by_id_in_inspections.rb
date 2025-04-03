class RenameCreatedByToCreatedByIdInInspections < ActiveRecord::Migration[8.0]
  def change
    rename_column :inspections, :created_by, :created_by_id
  end
end
