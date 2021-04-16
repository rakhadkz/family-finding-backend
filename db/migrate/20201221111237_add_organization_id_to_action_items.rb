class AddOrganizationIdToActionItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :action_items, :organization, foreign_key: true
  end
end
