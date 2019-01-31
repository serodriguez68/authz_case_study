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

ActiveRecord::Schema.define(version: 2019_01_16_125220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authz_business_process_has_controller_actions", force: :cascade do |t|
    t.bigint "authz_controller_action_id"
    t.bigint "authz_business_process_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authz_business_process_id"], name: "authz_bphca_business_process_index"
    t.index ["authz_controller_action_id"], name: "authz_bphca_controller_action_index"
  end

  create_table "authz_business_processes", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authz_controller_actions", force: :cascade do |t|
    t.string "controller"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authz_role_grants", force: :cascade do |t|
    t.bigint "authz_role_id", null: false
    t.string "rolable_type", null: false
    t.bigint "rolable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authz_role_id"], name: "authz_role_grants_role_index"
    t.index ["rolable_type", "rolable_id"], name: "authz_role_grants_rolable_index"
  end

  create_table "authz_role_has_business_processes", force: :cascade do |t|
    t.bigint "authz_business_process_id"
    t.bigint "authz_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authz_business_process_id"], name: "authz_rhbp_business_process_index"
    t.index ["authz_role_id"], name: "authz_rhbp_role_index"
  end

  create_table "authz_roles", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authz_scoping_rules", force: :cascade do |t|
    t.string "scopable"
    t.bigint "authz_role_id", null: false
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authz_role_id"], name: "index_authz_scoping_rules_on_authz_role_id"
    t.index ["keyword"], name: "index_authz_scoping_rules_on_keyword"
    t.index ["scopable"], name: "index_authz_scoping_rules_on_scopable"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "city_id"
    t.string "pickup_address"
    t.string "drop_off_address"
    t.datetime "accepted_on"
    t.datetime "finished_on"
    t.datetime "cancelled_on"
    t.bigint "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_services_on_city_id"
    t.index ["client_id"], name: "index_services_on_client_id"
    t.index ["driver_id"], name: "index_services_on_driver_id"
  end

  create_table "staff_members", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_staff_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authz_business_process_has_controller_actions", "authz_business_processes"
  add_foreign_key "authz_business_process_has_controller_actions", "authz_controller_actions"
  add_foreign_key "authz_role_grants", "authz_roles"
  add_foreign_key "authz_role_has_business_processes", "authz_business_processes"
  add_foreign_key "authz_role_has_business_processes", "authz_roles"
  add_foreign_key "authz_scoping_rules", "authz_roles"
  add_foreign_key "clients", "users"
  add_foreign_key "drivers", "users"
  add_foreign_key "services", "cities"
  add_foreign_key "services", "clients"
  add_foreign_key "services", "drivers"
  add_foreign_key "staff_members", "users"
end
