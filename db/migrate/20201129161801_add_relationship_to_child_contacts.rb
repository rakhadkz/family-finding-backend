class AddRelationshipToChildContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :relationship, :string
  end
end
