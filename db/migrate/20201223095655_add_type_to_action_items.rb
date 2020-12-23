class AddTypeToActionItems < ActiveRecord::Migration[6.0]
  def change
    add_column :action_items, :action_type, :string
  end
end
