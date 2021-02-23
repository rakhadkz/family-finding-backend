class CreateFamilySearchAttachment < ActiveRecord::Migration[6.0]
  def change
    create_table :family_search_attachments do |t|
      t.references :family_search, foreign_key: true
      t.references :attachment, foreign_key: true

      t.timestamps
    end
  end
end
