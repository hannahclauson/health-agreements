class UpdateTo10 < ActiveRecord::Migration
  def change

    create_table "legal_documents", force: :cascade do |t|
      t.string   "name"
      t.string   "url"
      t.integer  "company_id"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    add_index "legal_documents", ["company_id"], name: "index_legal_documents_on_company_id", using: :btree

    # Update practices schema

    add_column "practices", "legal_document_id", :integer
    add_index "practices", ["legal_document_id"], name: "index_practices_on_legal_document_id", using: :btree


    create_table "journals", force: :cascade do |t|
      t.string "name"
      t.string "url"
      t.float "impact_factor"
      t.string "slug"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "articles", force: :cascade do |t|
      t.string   "title"
      t.string   "summary_url"
      t.string   "download_url"
      t.integer  "company_id"
      t.integer  "journal_id"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    add_index "articles", ["company_id"], name: "index_articles_on_company_id", using: :btree
    add_index "articles", ["journal_id"], name: "index_articles_on_journal_id", using: :btree

    create_table "contributions", force: :cascade do |t|
      t.string   "kind"
      t.string   "url"
      t.string   "email"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end



  end
end
