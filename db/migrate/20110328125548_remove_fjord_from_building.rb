class RemoveFjordFromBuilding < ActiveRecord::Migration
  def self.up
    remove_column :buildings, :fjord_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration.new
  end
end
