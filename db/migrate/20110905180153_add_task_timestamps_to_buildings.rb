class AddTaskTimestampsToBuildings < ActiveRecord::Migration
  def self.up
    add_column :buildings, :assigned_at, :timestamp
    add_column :buildings, :completed_at, :timestamp
  end

  def self.down
    remove_column :buildings, :assigned_at
    remove_column :buildings, :completed_at
  end
end
