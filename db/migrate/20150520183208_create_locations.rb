class CreateLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :slug, indexed: true
      t.boolean :keeps_hours, default: false
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
