class DropConnectionAttachments < ActiveRecord::Migration[6.0]
  def change
    drop_table :connection_attachments
    drop_table :connection_comments
  end
end
