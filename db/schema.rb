# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_22_084032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chomp_sessions", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "unique_identifier"
    t.string "status"
    t.integer "session_expiry"
    t.bigint "user_id", null: false
    t.bigint "restaurant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "time"
    t.index ["restaurant_id"], name: "index_chomp_sessions_on_restaurant_id"
    t.index ["user_id"], name: "index_chomp_sessions_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.integer "budget"
    t.string "location"
    t.string "email"
    t.string "cuisine"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id", null: false
    t.bigint "chomp_session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chomp_session_id"], name: "index_responses_on_chomp_session_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "opening_time"
    t.datetime "closing_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cuisine"
    t.string "photo_url"
    t.float "average_rating"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "rating"
    t.bigint "user_id", null: false
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chomp_sessions", "restaurants"
  add_foreign_key "chomp_sessions", "users"
  add_foreign_key "responses", "chomp_sessions"
  add_foreign_key "responses", "users"
  add_foreign_key "reviews", "restaurants"
  add_foreign_key "reviews", "users"
end
