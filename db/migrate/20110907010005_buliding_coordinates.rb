class BulidingCoordinates < ActiveRecord::Migration
  def self.up
    add_column :buildings, :x, :integer
    add_column :buildings, :y, :integer
  end

  def self.down
    remove_column :buildings, :x
    remove_column :buildings, :y
  end
end
