class CreateLibraries < ActiveRecord::Migration[4.2]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :slug, indexed: true

      t.timestamps null: false
    end
  end
end
