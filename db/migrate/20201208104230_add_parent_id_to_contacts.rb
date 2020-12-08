class AddParentIdToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :parent_id, :bigint
  end
end
