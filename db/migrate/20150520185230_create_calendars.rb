class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.datetime :dtstart, indexed: true
      t.datetime :dtend, indexed: true
      t.references :location, index: true, foreign_key: true
      t.string :summary
      t.text :description
      t.boolean :closed

      t.timestamps null: false
    end
  end
end
