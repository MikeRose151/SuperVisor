class RemoveActiveFromInspections < ActiveRecord::Migration[8.0]
  def change
    remove_column :inspections, :active, :boolean
  end
end
