class AddLevelToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :height, :integer, :default => 0
  end
end
