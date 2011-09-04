class AddNameToVillages < ActiveRecord::Migration
  def self.up
    add_column :villages, :name, :string
  end

  def self.down
    remove_column :villages, :name
  end
end
