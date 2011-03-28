class CreateBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings do |t|
      t.integer :village_id
      t.integer :fjord_id
      t.timestamps
    end
    
    add_index :buildings, :village_id
    add_index :buildings, :fjord_id
  end

  def self.down
    drop_table :buildings
  end
end
