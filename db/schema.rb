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

ActiveRecord::Schema[8.1].define(version: 2026_02_08_033526) do
  create_table "activity_reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.json "data", default: {}
    t.integer "generated_by_id", null: false
    t.date "period_end", null: false
    t.date "period_start", null: false
    t.integer "report_type", default: 0, null: false
    t.integer "school_id"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["generated_by_id"], name: "index_activity_reports_on_generated_by_id"
    t.index ["school_id"], name: "index_activity_reports_on_school_id"
    t.index ["user_id"], name: "index_activity_reports_on_user_id"
  end

  create_table "ai_dialogues", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.integer "student_question_id", null: false
    t.datetime "updated_at", null: false
    t.index ["student_question_id"], name: "index_ai_dialogues_on_student_question_id"
  end

  create_table "announcements", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "published_at"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_announcements_on_user_id"
  end

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

  create_table "learning_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_bloom_stage", default: 1, null: false
    t.integer "passage_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["passage_id"], name: "index_learning_sessions_on_passage_id"
    t.index ["user_id", "status"], name: "index_learning_sessions_on_user_id_and_status"
    t.index ["user_id"], name: "index_learning_sessions_on_user_id"
  end

  create_table "parent_students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "parent_id", null: false
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id", "student_id"], name: "index_parent_students_on_parent_id_and_student_id", unique: true
    t.index ["parent_id"], name: "index_parent_students_on_parent_id"
    t.index ["student_id"], name: "index_parent_students_on_student_id"
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

  create_table "program_assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "program_id", null: false
    t.integer "school_id", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id", "school_id"], name: "index_program_assignments_on_program_id_and_school_id", unique: true
    t.index ["program_id"], name: "index_program_assignments_on_program_id"
    t.index ["school_id"], name: "index_program_assignments_on_school_id"
  end

  create_table "program_passages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "passage_id", null: false
    t.integer "position", default: 0, null: false
    t.integer "program_id", null: false
    t.datetime "updated_at", null: false
    t.index ["passage_id"], name: "index_program_passages_on_passage_id"
    t.index ["program_id", "passage_id"], name: "index_program_passages_on_program_id_and_passage_id", unique: true
    t.index ["program_id"], name: "index_program_passages_on_program_id"
  end

  create_table "programs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "ends_on", null: false
    t.string "name", null: false
    t.date "starts_on", null: false
    t.integer "target_grade_max", null: false
    t.integer "target_grade_min", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer "base_question_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "learning_session_id", null: false
    t.datetime "updated_at", null: false
    t.index ["base_question_id"], name: "index_responses_on_base_question_id"
    t.index ["learning_session_id"], name: "index_responses_on_learning_session_id"
  end

  create_table "school_enrollments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "role_in_school", default: 0, null: false
    t.integer "school_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["school_id", "user_id"], name: "index_school_enrollments_on_school_id_and_user_id", unique: true
    t.index ["school_id"], name: "index_school_enrollments_on_school_id"
    t.index ["user_id"], name: "index_school_enrollments_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "region"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_schools_on_name"
  end

  create_table "session_summaries", force: :cascade do |t|
    t.json "bloom_distribution", default: {}
    t.json "competency_scores", default: {}
    t.datetime "created_at", null: false
    t.text "highlight_question"
    t.integer "learning_session_id", null: false
    t.text "summary", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_session_id"], name: "index_session_summaries_on_learning_session_id"
  end

  create_table "student_questions", force: :cascade do |t|
    t.integer "bloom_level", default: 0, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "learning_session_id", null: false
    t.datetime "updated_at", null: false
    t.index ["bloom_level"], name: "index_student_questions_on_bloom_level"
    t.index ["learning_session_id"], name: "index_student_questions_on_learning_session_id"
  end

  create_table "system_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.index ["key"], name: "index_system_settings_on_key", unique: true
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

  add_foreign_key "activity_reports", "schools"
  add_foreign_key "activity_reports", "users"
  add_foreign_key "activity_reports", "users", column: "generated_by_id"
  add_foreign_key "ai_dialogues", "student_questions"
  add_foreign_key "announcements", "users"
  add_foreign_key "base_questions", "passages"
  add_foreign_key "learning_sessions", "passages"
  add_foreign_key "learning_sessions", "users"
  add_foreign_key "parent_students", "users", column: "parent_id"
  add_foreign_key "parent_students", "users", column: "student_id"
  add_foreign_key "program_assignments", "programs"
  add_foreign_key "program_assignments", "schools"
  add_foreign_key "program_passages", "passages"
  add_foreign_key "program_passages", "programs"
  add_foreign_key "responses", "base_questions"
  add_foreign_key "responses", "learning_sessions"
  add_foreign_key "school_enrollments", "schools"
  add_foreign_key "school_enrollments", "users"
  add_foreign_key "session_summaries", "learning_sessions"
  add_foreign_key "student_questions", "learning_sessions"
end
