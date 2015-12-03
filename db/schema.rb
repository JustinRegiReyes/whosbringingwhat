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

ActiveRecord::Schema.define(version: 20151202092910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attending_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "event_id"
  end

  create_table "attending_events_users", id: false, force: :cascade do |t|
    t.integer "user_id",            null: false
    t.integer "attending_event_id", null: false
  end

  add_index "attending_events_users", ["attending_event_id", "user_id"], name: "index_attending_events_users_on_attending_event_id_and_user_id", using: :btree
  add_index "attending_events_users", ["user_id", "attending_event_id"], name: "index_attending_events_users_on_user_id_and_attending_event_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "item_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.time     "time"
    t.string   "where"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "username"
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
