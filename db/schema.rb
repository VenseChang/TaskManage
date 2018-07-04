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

ActiveRecord::Schema.define(version: 2018_07_03_090640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "avatar"
    t.string "role"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "description"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_tasks", id: false, force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "tag_id", null: false
    t.index ["task_id", "tag_id"], name: "index_tags_tasks_on_task_id_and_tag_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "end_time"
    t.integer "priority"
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.index ["task_id", "user_id"], name: "index_tasks_users_on_task_id_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "tasks", "users"
end
