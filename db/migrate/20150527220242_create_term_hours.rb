class CreateTermHours < ActiveRecord::Migration
  def change
    create_table :term_hours do |t|
      t.references :term, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.text :data

      t.timestamps null: false
    end
  end
end
