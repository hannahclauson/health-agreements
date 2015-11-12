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

    create_table "contributions", force: :cascade do |t|
      t.string   "kind"
      t.string   "url"
      t.string   "email"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

  end
end
