class AddFileIdToAttachments < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :file_id, :string
  end
end
