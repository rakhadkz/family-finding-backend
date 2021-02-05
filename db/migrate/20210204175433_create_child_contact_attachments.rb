class CreateChildContactAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :child_contact_attachments do |t|
      t.references :child_contact, foreign_key: true
      t.references :attachment, foreign_key: true

      t.timestamps
    end
  end
end
