class CreateBowlers < ActiveRecord::Migration
  def change
    create_table :bowlers do |t|
      t.string :name, null: false
      t.string :usbc_id

      t.timestamps
    end
  end
end
