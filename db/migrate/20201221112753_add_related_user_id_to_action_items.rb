class AddRelatedUserIdToActionItems < ActiveRecord::Migration[6.0]
  def change
    add_column :action_items, :related_user_id, :bigint
  end
end
