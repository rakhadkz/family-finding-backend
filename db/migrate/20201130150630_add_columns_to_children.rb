class AddColumnsToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :race, :string
    add_column :children, :gender, :string
    add_column :children, :permanency_status, :string
  end
end
