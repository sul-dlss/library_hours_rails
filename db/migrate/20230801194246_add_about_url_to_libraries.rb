class AddAboutUrlToLibraries < ActiveRecord::Migration[7.0]
  def change
    add_column :libraries, :about_url, :string
  end
end
