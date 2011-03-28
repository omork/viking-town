class CreateVillagers < ActiveRecord::Migration
  def self.up
    create_table :villagers do |t|
      t.integer :village_id
      t.integer :building_id
      t.timestamps
    end
    
    add_index :villagers, :village_id
    add_index :villagers, :building_id
  end

  def self.down
    drop_table :villagers
  end
end
