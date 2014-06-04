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

ActiveRecord::Schema.define(version: 20140529034419) do

  create_table "account_in_roles", id: false, force: true do |t|
    t.integer "account_id"
    t.integer "role_id"
    t.text    "description"
  end

  add_index "account_in_roles", ["account_id"], name: "index_account_in_roles_on_account_id"
  add_index "account_in_roles", ["role_id"], name: "index_account_in_roles_on_role_id"

  create_table "accounts", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.text     "email"
    t.text     "phone"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_processings", force: true do |t|
    t.integer  "order_id"
    t.integer  "account_id"
    t.integer  "status"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_processings", ["account_id"], name: "index_order_processings_on_account_id"
  add_index "order_processings", ["order_id"], name: "index_order_processings_on_order_id"

  create_table "orders", force: true do |t|
    t.integer  "customer_id"
    t.text     "from"
    t.text     "to"
    t.datetime "depart"
    t.datetime "return"
    t.integer  "adult"
    t.integer  "seniors"
    t.integer  "children"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "resource_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "roles", force: true do |t|
    t.integer  "type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
