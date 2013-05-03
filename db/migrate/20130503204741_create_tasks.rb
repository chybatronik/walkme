class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :text
      t.text :url
      t.text :object

      t.timestamps
    end
  end
end
