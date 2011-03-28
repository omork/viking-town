class RemoveUserFromShips < ActiveRecord::Migration
  def self.up
    remove_index :ships, :user_id
    remove_column :ships, :user_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration.new
  end
end
