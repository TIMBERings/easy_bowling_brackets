class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :event_date
      t.references :user, index: true
      t.decimal :winner_cut
      t.decimal :runner_up_cut
      t.decimal :organizer_cut
      t.decimal :entry_cost

      t.timestamps
    end
  end
end
