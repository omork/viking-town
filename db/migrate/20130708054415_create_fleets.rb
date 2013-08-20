class CreateFleets < ActiveRecord::Migration
  def change
    create_table :fleets do |t|
      t.integer   :user_id,   :index
      t.integer   :village_id, :index
      t.timestamp :docked_at, :index
      t.integer   :position
      t.text      :resources
      t.timestamps
    end
  end
end
