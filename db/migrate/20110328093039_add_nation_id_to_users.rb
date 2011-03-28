class AddNationIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nation_id, :integer
    add_index :users, :nation_id
  end

  def self.down
    remove_column :users, :nation_id
  end
end
