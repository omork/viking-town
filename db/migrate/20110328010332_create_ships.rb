class CreateShips < ActiveRecord::Migration
  def self.up
    create_table :ships do |t|
      t.integer :fjord_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :ships, :fjord_id
    add_index :ships, :user_id
  end

  def self.down
    drop_table :ships
  end
end
