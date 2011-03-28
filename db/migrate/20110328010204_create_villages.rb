class CreateVillages < ActiveRecord::Migration
  def self.up
    create_table :villages do |t|
      t.integer :fjord_id
      t.timestamps
    end
    
    add_index :villages, :fjord_id
  end

  def self.down
    drop_table :villages
  end
end
