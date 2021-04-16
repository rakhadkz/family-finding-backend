class AddRelativesCountToFamilySearches < ActiveRecord::Migration[6.0]
  def change
    add_column :family_searches, :relatives_count, :integer
    add_column :family_searches, :current_relatives, :integer
  end
end
