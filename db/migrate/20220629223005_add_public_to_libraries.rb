class AddPublicToLibraries < ActiveRecord::Migration[7.0]
  def change
    add_column :libraries, :public, :boolean, default: true
  end
end
