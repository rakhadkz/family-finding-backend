class AddSystemStatusToChildren < ActiveRecord::Migration[6.0]
  def change
    add_column :children, :system_status, :string
  end
end
