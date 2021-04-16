class AddOrganizationToSearchVector < ActiveRecord::Migration[6.0]
  def change
    add_reference :search_vectors, :organization, foreign_key: true
  end
end
