class CreateFjords < ActiveRecord::Migration
  def self.up
    create_table :fjords do |t|
      t.integer :user_id
      t.integer :nation_id
      t.timestamps
    end
    
    add_index :fjords, :user_id
    add_index :fjords, :nation_id
  end

  def self.down
    drop_table :fjords
  end
end
