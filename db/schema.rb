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

ActiveRecord::Schema.define(version: 20150908004432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archetypes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "guidelines", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "true_description"
    t.text     "false_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "practices", force: :cascade do |t|
    t.text     "notes"
    t.integer  "implementation"
    t.integer  "company_id"
    t.integer  "guideline_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "archetypes_id"
  end

  add_index "practices", ["company_id"], name: "index_practices_on_company_id", using: :btree
  add_index "practices", ["guideline_id"], name: "index_practices_on_guideline_id", using: :btree

  add_foreign_key "practices", "companies"
  add_foreign_key "practices", "guidelines"
end
