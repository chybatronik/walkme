class AddDeviseColumnsToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :authentication_token
    end
    add_index :users, :authentication_token, :unique => true
  end
  def self.down
    t.remove :authentication_token
  end
end
