class CreateBowlers < ActiveRecord::Migration
  def change
    create_table :bowlers do |t|
      t.string :name
      t.integer :starting_lane
      t.decimal :paid
      t.boolean :rejected

      t.timestamps
    end
  end
end
