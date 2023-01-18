class AddPrimaryToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :primary, :boolean, default: false
  end
end
