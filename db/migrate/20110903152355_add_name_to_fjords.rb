class AddNameToFjords < ActiveRecord::Migration
  def self.up
    add_column :fjords, :name, :string
  end

  def self.down
    remove_column :fjords, :name
  end
end
