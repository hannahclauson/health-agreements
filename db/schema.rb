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

ActiveRecord::Schema.define(version: 20150917183836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "archetypes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "company_id"
    t.integer  "archetype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "badges", ["archetype_id"], name: "index_badges_on_archetype_id", using: :btree
  add_index "badges", ["company_id"], name: "index_badges_on_company_id", using: :btree

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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "archetype_id"
    t.integer  "practiceable_id"
    t.string   "practiceable_type"
  end

  add_index "practices", ["archetype_id"], name: "index_practices_on_archetype_id", using: :btree
  add_index "practices", ["company_id"], name: "index_practices_on_company_id", using: :btree
  add_index "practices", ["guideline_id"], name: "index_practices_on_guideline_id", using: :btree
  add_index "practices", ["practiceable_type", "practiceable_id"], name: "index_practices_on_practiceable_type_and_practiceable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role",                   default: 0,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "badges", "archetypes"
  add_foreign_key "badges", "companies"
  add_foreign_key "practices", "companies"
  add_foreign_key "practices", "guidelines"
end
