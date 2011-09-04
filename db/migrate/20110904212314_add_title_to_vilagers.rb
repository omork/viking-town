class AddTitleToVilagers < ActiveRecord::Migration
  def self.up
    add_column :villagers, :title, :string
  end

  def self.down
    remove_column :villagers, :title
  end
end
