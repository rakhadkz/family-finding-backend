class RemoveStatusAndPriorityLevelFromActionItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :action_items, :status, :string
    remove_column :action_items, :priority_level, :integer
  end
end
