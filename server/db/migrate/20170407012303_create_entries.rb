class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :bracket_group, index: true, null: false
      t.integer :starting_lane
      t.integer :entry_count, default: 0, null: false
      t.boolean :paid, default: false, null: false
      t.integer :rejected_count, default: 0, null: false
      t.boolean :refunded, default: false, null: false
      t.integer :average
      t.references :bowler, index: true, null: false

      t.timestamps
    end
  end
end
