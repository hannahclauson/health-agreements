class CreateArchetypes < ActiveRecord::Migration
  def change
    create_table :archetypes do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    add_reference :practices, :archetype, on_delete: :cascade, index: true

  end
end
