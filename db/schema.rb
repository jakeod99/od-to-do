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

ActiveRecord::Schema[8.0].define(version: 2025_01_11_212944) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "recurring_task_template_status", ["draft", "inactive", "active", "discarded"]
  create_enum "task_status", ["draft", "unstarted", "in progress", "completed", "failed", "skipped", "discarded"]
  create_enum "tasks_waves_status", ["planned", "rolled", "completed", "foresaken"]
  create_enum "wave_status", ["waiting", "active", "completed"]

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "color"
    t.string "icon", default: "regex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "categories_recurring_task_templates", force: :cascade do |t|
    t.uuid "recurring_task_template_id", null: false
    t.uuid "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_recurring_task_templates_on_category_id"
    t.index ["recurring_task_template_id"], name: "idx_on_recurring_task_template_id_965a8d53f0"
  end

  create_table "categories_tasks", force: :cascade do |t|
    t.uuid "task_id", null: false
    t.uuid "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_tasks_on_category_id"
    t.index ["task_id"], name: "index_categories_tasks_on_task_id"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "color"
    t.string "icon", default: "people"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "groups_users", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "recurring_task_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.enum "status", default: "draft", null: false, enum_type: "recurring_task_template_status"
    t.string "type"
    t.text "days"
    t.string "title"
    t.text "description"
    t.boolean "is_firm"
    t.integer "complexity", limit: 2, default: 2
    t.integer "urgency", limit: 2, default: 2
    t.uuid "author_id", null: false
    t.string "assignable_type"
    t.uuid "assignable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignable_type", "assignable_id"], name: "index_recurring_task_templates_on_assignable"
    t.index ["author_id"], name: "index_recurring_task_templates_on_author_id"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.enum "status", default: "draft", null: false, enum_type: "task_status"
    t.string "title"
    t.text "description"
    t.datetime "firm_due"
    t.datetime "suggested_due"
    t.integer "complexity", limit: 2, default: 2
    t.integer "urgency", limit: 2, default: 2
    t.string "authorable_type", null: false
    t.uuid "authorable_id", null: false
    t.string "assignable_type"
    t.uuid "assignable_id"
    t.uuid "completed_by_id"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignable_type", "assignable_id"], name: "index_tasks_on_assignable"
    t.index ["authorable_type", "authorable_id"], name: "index_tasks_on_authorable"
    t.index ["completed_by_id"], name: "index_tasks_on_completed_by_id"
  end

  create_table "tasks_waves", force: :cascade do |t|
    t.uuid "task_id", null: false
    t.uuid "wave_id", null: false
    t.enum "status", default: "planned", null: false, enum_type: "tasks_waves_status"
    t.boolean "in_initial_commitment", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_tasks_waves_on_task_id"
    t.index ["wave_id"], name: "index_tasks_waves_on_wave_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["password_digest"], name: "index_users_on_password_digest", unique: true
  end

  create_table "waves", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.enum "status", default: "waiting", null: false, enum_type: "wave_status"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories_recurring_task_templates", "categories"
  add_foreign_key "categories_recurring_task_templates", "recurring_task_templates"
  add_foreign_key "categories_tasks", "categories"
  add_foreign_key "categories_tasks", "tasks"
  add_foreign_key "groups_users", "groups"
  add_foreign_key "groups_users", "users"
  add_foreign_key "recurring_task_templates", "users", column: "author_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "tasks", "users", column: "completed_by_id"
  add_foreign_key "tasks_waves", "tasks"
  add_foreign_key "tasks_waves", "waves"
end
