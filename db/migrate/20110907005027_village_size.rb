class VillageSize < ActiveRecord::Migration
  def self.up
    add_column :villages, :width, :integer, :default => 9
    add_column :villages, :height, :integer, :default => 3
  end

  def self.down
    remove_column :villages, :width
    remove_column :villages, :height
  end
end
