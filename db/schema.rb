# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170207001541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bowlers", force: :cascade do |t|
    t.string   "name",                           null: false
    t.integer  "starting_lane"
    t.decimal  "paid",           default: "0.0", null: false
    t.integer  "rejected_count", default: 0,     null: false
    t.integer  "average"
    t.integer  "entries",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bowlers_brackets", force: :cascade do |t|
    t.integer "bowler_id"
    t.integer "bracket_id"
    t.index ["bowler_id"], name: "index_bowlers_brackets_on_bowler_id", using: :btree
    t.index ["bracket_id"], name: "index_bowlers_brackets_on_bracket_id", using: :btree
  end

  create_table "bracket_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "event_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_bracket_groups_on_event_id", using: :btree
  end

  create_table "brackets", force: :cascade do |t|
    t.integer  "bracket_group_id"
    t.json     "seeds"
    t.json     "results"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["bracket_group_id"], name: "index_brackets_on_bracket_group_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",          null: false
    t.date     "event_date",    null: false
    t.integer  "user_id",       null: false
    t.decimal  "winner_cut",    null: false
    t.decimal  "runner_up_cut", null: false
    t.decimal  "organizer_cut", null: false
    t.decimal  "entry_cost",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "brackets", "bracket_groups"
end
