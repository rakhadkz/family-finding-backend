class AddDateRemovedToActionItems < ActiveRecord::Migration[6.0]
  def change
    add_column :action_items, :date_removed, :datetime, default: nil
  end
end
