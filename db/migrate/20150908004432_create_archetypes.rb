class CreateArchetypes < ActiveRecord::Migration
  def change
    create_table :archetypes do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    change_table :practices do |t|
      t.belongs_to :archetype, index: true, foreign_key: true
    end

  end
end
