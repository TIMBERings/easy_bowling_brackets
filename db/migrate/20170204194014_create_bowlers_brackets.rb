class CreateBowlersBrackets < ActiveRecord::Migration
  def change
    create_table :bowlers_brackets do |t|
      t.belongs_to :bowler, index: true
      t.belongs_to :bracket, index: true
    end
  end
end
