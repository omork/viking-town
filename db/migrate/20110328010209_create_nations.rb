class CreateNations < ActiveRecord::Migration
  def self.up
    create_table :nations do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :nations
  end
end
