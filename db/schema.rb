# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130705211048) do

  create_table "buildings", force: true do |t|
    t.integer  "village_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "task"
    t.datetime "assigned_at"
    t.datetime "completed_at"
    t.integer  "x"
    t.integer  "y"
    t.integer  "height",       default: 0
  end

  add_index "buildings", ["village_id"], name: "index_buildings_on_village_id"

  create_table "fjords", force: true do |t|
    t.integer  "user_id"
    t.integer  "nation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "fjords", ["nation_id"], name: "index_fjords_on_nation_id"
  add_index "fjords", ["user_id"], name: "index_fjords_on_user_id"

  create_table "gods", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.text     "perks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "sacrifices", force: true do |t|
    t.text     "resources"
    t.integer  "god_id"
    t.integer  "village_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sacrifices", ["god_id"], name: "index_sacrifices_on_god_id"
  add_index "sacrifices", ["village_id"], name: "index_sacrifices_on_village_id"

  create_table "ships", force: true do |t|
    t.integer  "fjord_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ships", ["fjord_id"], name: "index_ships_on_fjord_id"

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",   limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nation_id"
    t.string   "username"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["nation_id"], name: "index_users_on_nation_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vikings", force: true do |t|
    t.integer  "ship_id"
    t.integer  "fjord_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vikings", ["fjord_id"], name: "index_vikings_on_fjord_id"
  add_index "vikings", ["ship_id"], name: "index_vikings_on_ship_id"

  create_table "village_resources", force: true do |t|
    t.integer  "village_id"
    t.text     "resources"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "villagers", force: true do |t|
    t.integer  "village_id"
    t.integer  "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "villagers", ["building_id"], name: "index_villagers_on_building_id"
  add_index "villagers", ["village_id"], name: "index_villagers_on_village_id"

  create_table "villages", force: true do |t|
    t.integer  "fjord_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "width",      default: 9
    t.integer  "height",     default: 3
    t.integer  "god_id"
  end

  add_index "villages", ["fjord_id"], name: "index_villages_on_fjord_id"
  add_index "villages", ["god_id"], name: "index_villages_on_god_id"

end
