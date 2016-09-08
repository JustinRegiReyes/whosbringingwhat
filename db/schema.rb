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

ActiveRecord::Schema.define(version: 20160908084451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attending_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "going"
    t.boolean  "maybe"
    t.boolean  "declined"
    t.boolean  "undecided",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "needed",      default: 0
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "post"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "photo"
    t.string   "banner"
    t.integer  "user_id"
    t.text     "description"
    t.date     "date_start"
    t.date     "date_end"
    t.time     "time_start"
    t.time     "time_end"
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "state"
    t.string   "country"
    t.string   "where"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "highlights"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "accepted",   default: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "comment_id"
    t.integer  "friendship_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "username"
    t.text     "comment_notifications",    default: [],              array: true
    t.text     "invitation_notifications", default: [],              array: true
    t.text     "invitations",              default: [],              array: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "avi_file_name"
    t.string   "avi_content_type"
    t.integer  "avi_file_size"
    t.datetime "avi_updated_at"
    t.string   "crop_x"
    t.string   "crop_y"
    t.string   "crop_w"
    t.string   "crop_h"
  end

end
