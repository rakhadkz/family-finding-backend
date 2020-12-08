class AddParentIdToChildContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :parent_id, :bigint
  end
end
