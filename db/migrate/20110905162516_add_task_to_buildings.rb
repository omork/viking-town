class AddTaskToBuildings < ActiveRecord::Migration
  def self.up
    add_column :buildings, :task, :string
  end

  def self.down
    remove_column :buildings, :task
  end
end
