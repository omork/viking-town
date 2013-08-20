class AddFleetIdToShips < ActiveRecord::Migration
  def change
    add_column :ships, :fleet_id, :integer, default: nil
    add_index  :ships, :fleet_id
  end
end
