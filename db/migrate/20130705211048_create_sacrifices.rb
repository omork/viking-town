class CreateSacrifices < ActiveRecord::Migration
  def change
    create_table :sacrifices do |t|
      t.text :resources
      t.integer :god_id
      t.integer :village_id

      t.timestamps
    end
    add_index :sacrifices, :god_id
    add_index :sacrifices, :village_id
  end
end
