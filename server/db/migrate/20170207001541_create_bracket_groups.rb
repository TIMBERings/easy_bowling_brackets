class CreateBracketGroups < ActiveRecord::Migration[5.0]
  def up
    create_table :bracket_groups do |t|
      t.string :name
      t.references :event, index: true, null: false

      t.timestamps
    end

    rename_column :brackets, :event_id, :bracket_group_id
    add_foreign_key :brackets, :bracket_groups
  end

  def down
    remove_foreign_key :brackets, :bracket_groups
    rename_column :brackets, :bracket_group_id, :event_id
    drop_table :bracket_groups
  end
end
