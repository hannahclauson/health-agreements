class AddTagsToGuidelines < ActiveRecord::Migration
  def change

    create_table "guideline_tag", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    add_column "guidelines", "guideline_tag_id", :integer
    add_index "guidelines", ["guideline_tag_id"], name: "index_guidelines_on_guideline_tag_id", using: :btree

  end
end
