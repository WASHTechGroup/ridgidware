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

ActiveRecord::Schema.define(version: 20150311230004) do

  create_table "carts", force: :cascade do |t|
    t.string   "owner",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "category_id",   limit: 4
    t.string   "category_name", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "costings", force: :cascade do |t|
    t.string   "part_no",    limit: 255
    t.integer  "count",      limit: 4
    t.float    "price_per",  limit: 24
    t.float    "price_ext",  limit: 24
    t.string   "supplier",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "demand_trackers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "holds", force: :cascade do |t|
    t.integer  "cart_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "paid",       limit: 1
    t.boolean  "void",       limit: 1
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "part_id",      limit: 4, null: false
    t.integer  "on_hand",      limit: 4
    t.integer  "on_order",     limit: 4
    t.integer  "on_hold",      limit: 4
    t.integer  "available",    limit: 4
    t.integer  "inv_position", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "order_no",   limit: 4
    t.float    "subtotal",   limit: 24
    t.float    "tax",        limit: 24
    t.float    "total",      limit: 24
    t.string   "po_number",  limit: 255
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "parts", force: :cascade do |t|
    t.string   "part_number", limit: 255,   null: false
    t.text     "description", limit: 65535
    t.string   "category",    limit: 255
    t.float    "price",       limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "parts_in_carts", force: :cascade do |t|
    t.integer  "cart_id",            limit: 4, null: false
    t.integer  "part_id",            limit: 4, null: false
    t.integer  "quantity_requested", limit: 4, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "parts_in_orders", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "part_id",           limit: 4
    t.integer  "quant_ordered",     limit: 4
    t.integer  "quant_received",    limit: 4
    t.integer  "quant_backordered", limit: 4
    t.float    "cost",              limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "po_payments", force: :cascade do |t|
    t.string   "po_number",  limit: 255
    t.integer  "order_no",   limit: 4
    t.integer  "cheque_no",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "receivings", force: :cascade do |t|
    t.integer  "part_id",           limit: 4
    t.integer  "quant_received",    limit: 4
    t.integer  "quant_backordered", limit: 4
    t.text     "comment",           limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "cart_id",      limit: 4,                null: false
    t.decimal  "subtotal",               precision: 10
    t.decimal  "tax",                    precision: 10
    t.decimal  "total",                  precision: 10
    t.decimal  "amount_given",           precision: 10
    t.decimal  "change",                 precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string  "username",    limit: 255, null: false
    t.string  "slug",        limit: 255
    t.integer "role_id",     limit: 4
    t.string  "firstname",   limit: 255
    t.string  "lastname",    limit: 255
    t.string  "email",       limit: 255
    t.string  "phonenumber", limit: 255
    t.integer "program",     limit: 4
    t.string  "term",        limit: 255
    t.integer "year",        limit: 4
    t.integer "cart_id",     limit: 4
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
