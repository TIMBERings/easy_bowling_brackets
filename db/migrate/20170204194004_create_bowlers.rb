class CreateBowlers < ActiveRecord::Migration
  def change
    create_table :bowlers do |t|
      t.string :name, null: false
      t.integer :starting_lane
      t.decimal :paid, null: false, default: 0
      t.integer :rejected_count, null: false, default: 0
      t.integer :average

      t.timestamps
    end
  end
end
