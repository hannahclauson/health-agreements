class CreateArchetypes < ActiveRecord::Migration
  def change
    create_table :archetypes do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

#    add_foreign_key :practices, :archetypes, on_delete: cascade #, :practices
    add_reference :practices, :archetype, on_delete: :cascade

  end
end
