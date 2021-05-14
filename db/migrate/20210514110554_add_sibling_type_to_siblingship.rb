class AddSiblingTypeToSiblingship < ActiveRecord::Migration[6.0]
  def change
    add_column :siblingships, :sibling_type, :string
  end
end
