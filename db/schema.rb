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

ActiveRecord::Schema.define(version: 2019_07_15_173403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goal_comments", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "author_id", null: false
    t.text "comment_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_goal_comments_on_subject_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "due_date"
    t.string "privacy", null: false
    t.string "completion", default: "Not completed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "completion"], name: "index_goals_on_user_id_and_completion"
    t.index ["user_id", "privacy", "completion"], name: "index_goals_on_user_id_and_privacy_and_completion"
  end

  create_table "user_comments", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "author_id", null: false
    t.text "comment_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_user_comments_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "goal_comments", "goals", column: "subject_id"
  add_foreign_key "goal_comments", "users", column: "author_id"
  add_foreign_key "goals", "users"
  add_foreign_key "user_comments", "users", column: "author_id"
  add_foreign_key "user_comments", "users", column: "subject_id"
end
