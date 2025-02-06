class AddNoteToLocation < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :note, :text
  end
end
