class AddStiToBuildings < ActiveRecord::Migration
  def self.up
    add_column :buildings, :type, :string
  end

  def self.down
    remove_column :buildings, :type
  end
end
