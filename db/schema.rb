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

ActiveRecord::Schema.define(version: 2020_05_29_154241) do

  create_table "genders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
  end

  create_table "household_addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "household_id"
    t.string "address_line_1", null: false
    t.string "address_line_2", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.string "zip_4", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["household_id"], name: "index_household_addresses_on_household_id", unique: true
  end

  create_table "households", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "household_number", null: false
    t.string "household_name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suffixes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
  end

  create_table "user_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "token", null: false
    t.string "secret"
    t.boolean "expires"
    t.datetime "expires_at"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
  end

  create_table "user_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "description"
    t.string "image"
    t.string "phone"
    t.string "urls"
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_info_id"
    t.bigint "user_credential_id"
    t.string "identification_code", null: false
    t.string "uid", null: false
    t.string "provider", null: false
    t.integer "added_by", null: false
    t.integer "last_updated_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_credential_id"], name: "index_users_on_user_credential_id"
    t.index ["user_info_id"], name: "index_users_on_user_info_id"
  end

  add_foreign_key "household_addresses", "households"
end
