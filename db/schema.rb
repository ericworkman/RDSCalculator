# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_17_223347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "loot_items", force: :cascade do |t|
    t.string "name"
    t.integer "probability"
    t.bigint "loot_table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "always"
    t.boolean "unique"
    t.integer "inner_table_id"
    t.integer "min", default: 1
    t.integer "max", default: 1
    t.index ["loot_table_id"], name: "index_loot_items_on_loot_table_id"
  end

  create_table "loot_tables", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 1
  end

  add_foreign_key "loot_items", "loot_tables"
  add_foreign_key "loot_items", "loot_tables", column: "inner_table_id"
end
