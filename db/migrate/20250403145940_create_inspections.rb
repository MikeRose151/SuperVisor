class CreateInspections < ActiveRecord::Migration[8.0]
  def change
    create_table :inspections do |t|
      t.string :name
      t.string :sheet_url_string
      t.integer :created_by
      t.boolean :active

      t.timestamps
    end
  end
end
