class CreateSheets < ActiveRecord::Migration[8.0]
  def change
    create_table :sheets do |t|
      t.string :name
      t.string :google_file_id
      t.string :url
      t.jsonb :owner_emails

      t.timestamps
    end
  end
end
