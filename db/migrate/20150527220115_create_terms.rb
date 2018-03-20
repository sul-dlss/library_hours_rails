class CreateTerms < ActiveRecord::Migration[4.2]
  def change
    create_table :terms do |t|
      t.datetime :dtstart
      t.datetime :dtend
      t.string :name
      t.boolean :holiday, default: false

      t.timestamps null: false
    end
  end
end
