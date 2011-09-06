class CreateVillageResources < ActiveRecord::Migration
  def self.up
    create_table :village_resources do |t|
      t.references :village
      
      t.text :resources

      t.timestamps
    end
  end

  def self.down
    drop_table :village_resources
  end
end
