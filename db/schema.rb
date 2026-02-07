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

ActiveRecord::Schema[8.1].define(version: 2026_02_07_224956) do
  create_table "base_questions", force: :cascade do |t|
    t.integer "bloom_level", default: 0, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "passage_id", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["bloom_level"], name: "index_base_questions_on_bloom_level"
    t.index ["passage_id"], name: "index_base_questions_on_passage_id"
  end

  create_table "passages", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "difficulty", default: 1, null: false
    t.integer "genre", default: 0, null: false
    t.integer "max_grade", null: false
    t.integer "min_grade", null: false
    t.string "subject_tags"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["difficulty"], name: "index_passages_on_difficulty"
    t.index ["genre"], name: "index_passages_on_genre"
    t.index ["min_grade", "max_grade"], name: "index_passages_on_min_grade_and_max_grade"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "grade_level"
    t.string "name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.integer "thinking_level", default: 1, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["grade_level"], name: "index_users_on_grade_level"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "base_questions", "passages"
end
