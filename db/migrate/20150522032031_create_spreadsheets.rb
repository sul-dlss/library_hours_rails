class CreateSpreadsheets < ActiveRecord::Migration
  def change
    create_table :spreadsheets do |t|
      t.string :attachment_id
      t.string :attachment_filename
      t.string :attachment_content_type
      t.integer :attachment_size
      t.string :status

      t.timestamps null: false
    end
  end
end
