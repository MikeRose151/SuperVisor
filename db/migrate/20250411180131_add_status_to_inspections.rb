class AddStatusToInspections < ActiveRecord::Migration[8.0]
  def change
    add_column :inspections, :status, :integer, default: 0, null: false
  end
end
