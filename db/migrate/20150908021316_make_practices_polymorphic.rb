class MakePracticesPolymorphic < ActiveRecord::Migration
  def up
    change_table :practices do |t|
      t.references :practiceable, :polymorphic => true, index: true
    end
  end

  def down
    change_table :practices do |t|
      t.remove_references :practiceable, :polymorphic => true, index: true
    end
  end
end
