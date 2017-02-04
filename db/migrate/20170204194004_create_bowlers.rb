class CreateBowlers < ActiveRecord::Migration
  def change
    create_table :bowlers do |t|
      t.string :name, null: false
      t.integer :starting_lane

      t.timestamps
    end
  end
end
