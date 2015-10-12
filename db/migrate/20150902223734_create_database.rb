class CreateDatabase < ActiveRecord::Migration
  def change
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

    # A badge-type, made up of many practices (and guidelines, via that)
    create_table "badges", force: :cascade do |t|
      t.string   "name"
      t.text     "description"
      t.string   "slug"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    # Instances of badges
    create_table "badge_awards", force: :cascade do |t|
      t.integer  "company_id"
      t.integer  "badge_id"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    add_index "badge_awards", ["badge_id"]
    add_index "badge_awards", ["company_id"]

    create_table "companies", force: :cascade do |t|
      t.string   "name"
      t.string   "slug"
      t.text     "description"
      t.string   "url"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    add_index "companies", ["name"]
    add_index "companies", ["slug"]

    # Each guideline is a single rule
    create_table "guidelines", force: :cascade do |t|
      t.string   "name"
      t.text     "description"
      t.text     "true_description"
      t.text     "false_description"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

    create_table "badge_practices" do |t|
      t.belongs_to :guideline, index: true
      t.belongs_to :badge, index: true
      t.integer  "implementation"
    end

    # Instances of guidelines w/ implementation data
    create_table "practices", force: :cascade do |t|
      t.text     "notes"
      t.integer  "implementation"
      t.integer  "company_id", index: true
      t.integer  "guideline_id", index: true
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

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
  end
end
