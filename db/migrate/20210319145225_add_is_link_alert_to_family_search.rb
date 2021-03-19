class AddIsLinkAlertToFamilySearch < ActiveRecord::Migration[6.0]
  def change
    add_column :family_searches, :is_link_alert, :boolean
  end
end
