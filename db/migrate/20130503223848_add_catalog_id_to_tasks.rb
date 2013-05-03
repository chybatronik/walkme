class AddCatalogIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :catalog_id, :integer
  end
end
