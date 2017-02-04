class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.references :event, index: true

      t.timestamps
    end
  end
end
