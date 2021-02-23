class CreateFamilySearchConnection < ActiveRecord::Migration[6.0]
  def change
    create_table :family_search_connections do |t|
      t.references :family_search, foreign_key: true
      t.references :child_contact, foreign_key: true

      t.timestamps
    end
  end
end
