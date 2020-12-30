class AddRelationshipToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :relationship, :string
  end
end
