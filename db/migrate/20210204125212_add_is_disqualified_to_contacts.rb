class AddIsDisqualifiedToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :is_disqualified, :boolean, default: false
  end
end
