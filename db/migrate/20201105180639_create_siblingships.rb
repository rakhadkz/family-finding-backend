class CreateSiblingships < ActiveRecord::Migration[6.0]
  def self.up
    create_table :siblingships do |t|
      t.integer :child_id
      t.integer :sibling_id
    end

    add_index(:siblingships, [:child_id, :sibling_id], :unique => true)
    add_index(:siblingships, [:sibling_id, :child_id], :unique => true)
  end

  def self.down
    remove_index(:siblingships, [:sibling_id, :child_id])
    remove_index(:siblingships, [:child_id, :sibling_id])
    drop_table :siblingships
  end
end
