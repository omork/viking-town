class CreateGods < ActiveRecord::Migration
  def change
    create_table :gods do |t|
      t.string :name
      t.string :description
      t.text :perks
      t.timestamps
    end

    add_reference :villages, :god, index: true
  end
end
