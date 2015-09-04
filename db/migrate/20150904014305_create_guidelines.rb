class CreateGuidelines < ActiveRecord::Migration
  def change
    create_table :guidelines do |t|
      t.string :name
      t.text :description
      t.text :true_description
      t.text :false_description

      t.timestamps null: false
    end
  end
end
