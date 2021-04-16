class CreateConnectionAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :connection_attachments do |t|
      t.references :contact, foreign_key: true
      t.references :attachment, foreign_key: true

      t.timestamps
    end
  end
end
