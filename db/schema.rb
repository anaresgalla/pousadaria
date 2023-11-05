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

ActiveRecord::Schema[7.1].define(version: 2023_11_05_182826) do
  create_table "lodges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "headline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bedrooms"
    t.integer "max_guests"
    t.boolean "pets"
    t.string "disabled_facilities"
    t.time "check_in"
    t.time "check_out"
    t.integer "status", default: 0
    t.string "email"
    t.string "phone_number"
    t.string "full_address"
    t.string "corporate_name"
    t.string "cnpj"
    t.text "payment_method"
    t.text "policies"
    t.integer "owner_id", null: false
    t.index ["owner_id"], name: "index_lodges_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "area"
    t.integer "max_guests"
    t.string "standard_overnight"
    t.boolean "bathroom"
    t.boolean "balcony"
    t.boolean "ac"
    t.boolean "tv"
    t.boolean "closet"
    t.boolean "disabled_facilities"
    t.boolean "safe"
    t.boolean "vacant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lodge_id", null: false
    t.index ["lodge_id"], name: "index_rooms_on_lodge_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "lodges", "owners"
  add_foreign_key "rooms", "lodges"
end
