class MakePracticesPolymorphic < ActiveRecord::Migration
  def up
    change_table :practices do |t|
      t.references :practiceable, :polymorphic => true, index: true

#      t.remove_references :company, index: true
#      t.remove_references :archetype, index: true
    end
  end

  def down
    change_table :practices do |t|
      t.remove_references :practiceable, :polymorphic => true, index: true
#      t.belongs_to :company, index: true, foreign_key: true
#      t.belongs_to :archetype, index: true, foreign_key: true
    end
  end
end
