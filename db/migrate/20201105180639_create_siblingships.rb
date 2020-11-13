class CreateSiblingships < ActiveRecord::Migration[6.0]
  def change
    create_table :siblingships do |t|
      t.references :child, null: false,  foreign_key: { to_table: :children }
      t.references :sibling, null: false, foreign_key: { to_table: :children }
    end

    add_index(:siblingships, [:child_id, :sibling_id], :unique => true)
    add_index(:siblingships, [:sibling_id, :child_id], :unique => true)
  end
end
