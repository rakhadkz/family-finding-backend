class AddFileFormatToAttachments < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :file_format, :string
  end
end
