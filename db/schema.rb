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

ActiveRecord::Schema.define(version: 20150527220242) do

  create_table "calendars", force: :cascade do |t|
    t.datetime "dtstart"
    t.datetime "dtend"
    t.integer  "location_id"
    t.string   "summary"
    t.text     "description"
    t.boolean  "closed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "calendars", ["location_id"], name: "index_calendars_on_location_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "libraries", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "keeps_hours", default: false
    t.integer  "library_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "locations", ["library_id"], name: "index_locations_on_library_id"

  create_table "node_mappings", force: :cascade do |t|
    t.integer  "node_id"
    t.integer  "mapped_id"
    t.string   "mapped_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "spreadsheets", force: :cascade do |t|
    t.string   "attachment_id"
    t.string   "attachment_filename"
    t.string   "attachment_content_type"
    t.integer  "attachment_size"
    t.string   "status"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "term_hours", force: :cascade do |t|
    t.integer  "term_id"
    t.integer  "location_id"
    t.text     "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "term_hours", ["location_id"], name: "index_term_hours_on_location_id"
  add_index "term_hours", ["term_id"], name: "index_term_hours_on_term_id"

  create_table "terms", force: :cascade do |t|
    t.datetime "dtstart"
    t.datetime "dtend"
    t.string   "name"
    t.boolean  "holiday",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
