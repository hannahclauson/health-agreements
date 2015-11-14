class AddTagsToGuidelines < ActiveRecord::Migration
  def change

    create_table "guideline_tags", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    # In the future, may want to categorize a guideline w more than one tag
    # For now, just one is fine

    add_column "guidelines", "guideline_tag_id", :integer
    add_index "guidelines", ["guideline_tag_id"], name: "index_guidelines_on_guideline_tag_id", using: :btree

  end
end
