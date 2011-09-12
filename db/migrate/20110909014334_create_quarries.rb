class CreateQuarries < ActiveRecord::Migration
  def change
    create_table :quarries do |t|

      t.timestamps
    end
  end
end
