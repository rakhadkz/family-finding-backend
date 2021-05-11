class AddStatusToChildContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :status, :string, default: 'not_set'
  end
end
