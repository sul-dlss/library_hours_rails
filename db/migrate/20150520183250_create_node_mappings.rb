class CreateNodeMappings < ActiveRecord::Migration
  def change
    create_table :node_mappings do |t|
      t.integer :node_id, indexed: true
      t.references :mapped, polymorphic: true, indexed: true

      t.timestamps null: false
    end
  end
end
