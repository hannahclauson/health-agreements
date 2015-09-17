class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.belongs_to :company, index: true, foreign_key: true
      t.belongs_to :archetype, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
