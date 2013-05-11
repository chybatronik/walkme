class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.text :url
      t.integer :user_id
      t.integer :catalog_id

      t.timestamps
    end
  end
end
