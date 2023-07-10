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

ActiveRecord::Schema[7.0].define(version: 2023_07_05_185740) do
  create_table "movies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "screen_id"
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_movies_on_screen_id"
    t.index ["user_id"], name: "index_movies_on_user_id"
  end

  create_table "screens", force: :cascade do |t|
    t.integer "theatre_id", null: false
    t.integer "seating_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theatre_id"], name: "index_screens_on_theatre_id"
  end

  create_table "theatres", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_theatres_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "screen_id", null: false
    t.integer "user_id", null: false
    t.string "alphanumeric_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "theatre_id", null: false
    t.index ["movie_id"], name: "index_tickets_on_movie_id"
    t.index ["screen_id"], name: "index_tickets_on_screen_id"
    t.index ["theatre_id"], name: "index_tickets_on_theatre_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.boolean "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
  end

  add_foreign_key "movies", "screens"
  add_foreign_key "movies", "users"
  add_foreign_key "screens", "theatres"
  add_foreign_key "theatres", "users"
  add_foreign_key "tickets", "movies"
  add_foreign_key "tickets", "screens"
  add_foreign_key "tickets", "theatres"
  add_foreign_key "tickets", "users"
end
