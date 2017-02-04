class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :event_date, null: false
      t.references :user, index: true, null: false
      t.decimal :winner_cut, null: false
      t.decimal :runner_up_cut, null: false
      t.decimal :organizer_cut, null: false
      t.decimal :entry_cost, null: false

      t.timestamps
    end
  end
end
