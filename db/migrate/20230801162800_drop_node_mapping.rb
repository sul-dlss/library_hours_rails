class DropNodeMapping < ActiveRecord::Migration[7.0]
  def change
    drop_table :node_mappings
  end
end
