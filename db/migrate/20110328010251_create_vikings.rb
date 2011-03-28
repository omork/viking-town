class CreateVikings < ActiveRecord::Migration
  def self.up
    create_table :vikings do |t|
      t.integer :ship_id
      t.integer :fjord_id
      t.timestamps
    end
    
    add_index :vikings, :ship_id
    add_index :vikings, :fjord_id
  end

  def self.down
    drop_table :vikings
  end
end
