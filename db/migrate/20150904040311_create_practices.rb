class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.text :notes
      t.integer :implementation
      t.belongs_to :company, index: true, foreign_key: true
      t.belongs_to :guideline, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
