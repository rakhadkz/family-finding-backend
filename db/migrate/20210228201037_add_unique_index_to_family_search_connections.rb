class AddUniqueIndexToFamilySearchConnections < ActiveRecord::Migration[6.0]
  def change
    add_index :family_search_connections, [:family_search_id, :child_contact_id], unique: true, name: :family_search_connections_unique
  end
end
