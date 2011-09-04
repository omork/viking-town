class AddNameToNation < ActiveRecord::Migration
  def self.up
    add_column :nations, :name, :string
  end

  def self.down
    remove_column :nations, :name
  end
end
