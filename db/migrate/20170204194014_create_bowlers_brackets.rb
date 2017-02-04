class CreateBowlersBrackets < ActiveRecord::Migration
  def change
    create_table :bowlers_brackets do |t|
      t.belongs_to :bowler, index: true
      t.belongs_to :bracket, index: true
      t.boolean :paid, null: false, default: false
      t.boolean :rejected, null: false, default: false

    end
  end
end
