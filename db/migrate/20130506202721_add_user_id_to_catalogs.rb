class AddUserIdToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :user_id, :integer
  end
end
