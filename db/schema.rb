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

ActiveRecord::Schema.define(version: 2019_07_30_220527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athlete_events", force: :cascade do |t|
    t.bigint "athlete_id"
    t.bigint "event_id"
    t.integer "medal", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_athlete_events_on_athlete_id"
    t.index ["event_id"], name: "index_athlete_events_on_event_id"
  end

  create_table "athletes", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.integer "age"
    t.integer "height"
    t.integer "weight"
    t.string "team"
    t.string "games"
    t.string "sport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_athletes_on_name", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  add_foreign_key "athlete_events", "athletes"
  add_foreign_key "athlete_events", "events"
end
