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

ActiveRecord::Schema[7.1].define(version: 2024_06_28_133449) do
  create_table "buses", force: :cascade do |t|
    t.string "bus_name"
    t.integer "bus_number"
    t.integer "bus_type", default: 0
    t.integer "price_of_a_single_seat"
    t.datetime "departure_datetime"
    t.string "departure_location"
    t.datetime "arrival_datetime"
    t.string "arrival_location"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_seats"
    t.integer "no_of_available_seats", default: 50
    t.index ["user_id"], name: "index_buses_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "bus_id", null: false
    t.integer "user_id", null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.boolean "paid", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "bus_id", null: false
    t.integer "seat_id", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "booking_date", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_reservations_on_bus_id"
    t.index ["seat_id"], name: "index_reservations_on_seat_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "seat_reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "seat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seat_id"], name: "index_seat_reservations_on_seat_id"
    t.index ["user_id"], name: "index_seat_reservations_on_user_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "bus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seat_number"
    t.boolean "selected", default: false
    t.integer "user_id"
    t.index ["bus_id"], name: "index_seats_on_bus_id"
    t.index ["user_id"], name: "index_seats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "name"
    t.string "contact"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buses", "users"
  add_foreign_key "payments", "buses"
  add_foreign_key "payments", "users"
  add_foreign_key "reservations", "buses"
  add_foreign_key "reservations", "seats"
  add_foreign_key "reservations", "users"
  add_foreign_key "seat_reservations", "seats"
  add_foreign_key "seat_reservations", "users"
  add_foreign_key "seats", "buses"
  add_foreign_key "seats", "users"
end
