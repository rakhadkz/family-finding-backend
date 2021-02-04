class AddIsConfirmedToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :is_confirmed, :boolean, default: false
    add_column :child_contacts, :is_placed, :boolean, default: false
  end
end
