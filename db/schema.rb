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

ActiveRecord::Schema.define(version: 20150218215620) do

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

  create_table "inventories", force: :cascade do |t|
    t.integer  "part_no",      limit: 4, null: false
    t.integer  "on_hand",      limit: 4
    t.integer  "on_order",     limit: 4
    t.integer  "on_hold",      limit: 4
    t.integer  "inv_position", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "order_no",             limit: 4
    t.integer  "part_no",              limit: 4
    t.integer  "order_quantity",       limit: 4
    t.float    "unit_cost",            limit: 24
    t.float    "cost",                 limit: 24
    t.float    "subtotal",             limit: 24
    t.float    "tax",                  limit: 24
    t.float    "total",                limit: 24
    t.integer  "quantity_received",    limit: 4
    t.integer  "quantity_backordered", limit: 4
    t.string   "comment",              limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "parts", force: :cascade do |t|
    t.integer  "part_no",         limit: 4,   null: false
    t.string   "description",     limit: 255
    t.float    "price",           limit: 24
    t.float    "cost",            limit: 24
    t.string   "defaultsupplier", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string  "username", limit: 255, null: false
    t.string  "slug",     limit: 255
    t.integer "role_id",  limit: 4
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
