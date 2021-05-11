class RemoveIsDisqualifiedAndIsPlacedFromChildContacts < ActiveRecord::Migration[6.0]
  def change
    remove_column :child_contacts, :is_disqualified, :boolean
    remove_column :child_contacts, :is_placed, :boolean
  end
end
