class AddHashToFamilySearch < ActiveRecord::Migration[6.0]
  def change
    add_column :family_searches, :hashed_description, :text
  end
end
