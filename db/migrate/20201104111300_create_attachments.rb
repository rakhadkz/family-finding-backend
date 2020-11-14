class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.string :file_name
      t.string :file_type
      t.string :file_url
      t.integer :file_size
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
