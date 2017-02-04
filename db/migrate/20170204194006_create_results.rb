class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :bracket, index: true
      t.json :results

      t.timestamps
    end
  end
end
