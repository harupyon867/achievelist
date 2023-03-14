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

ActiveRecord::Schema[7.0].define(version: 2023_03_06_194140) do
  create_table "cleared_tasks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.datetime "limit", null: false
    t.string "priority", null: false
    t.index ["user_id"], name: "index_cleared_tasks_on_user_id"
  end

  create_table "task_clear_events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "cleared_task_id", null: false
    t.datetime "event_datetime", null: false
    t.index ["cleared_task_id"], name: "index_task_clear_events_on_cleared_task_id"
  end

  create_table "tasks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.datetime "limit", null: false
    t.string "priority", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "password_digest", null: false
    t.string "name", null: false
  end

  add_foreign_key "cleared_tasks", "users"
  add_foreign_key "task_clear_events", "cleared_tasks"
  add_foreign_key "tasks", "users"
end
