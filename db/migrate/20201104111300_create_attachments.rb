class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.references :child, foreign_key: true
      t.string :filename
      t.string :filetype
      t.text :filelocation

      t.timestamps
    end
  end
end
