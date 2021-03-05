class AddBlocksToFamilySearch < ActiveRecord::Migration[6.0]
  def change
    add_column :family_searches, :blocks, :text
  end
end
