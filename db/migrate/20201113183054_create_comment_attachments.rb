class CreateCommentAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_attachments do |t|
      t.belongs_to :comment
      t.belongs_to :attachment
      t.timestamps
    end

    add_index(:comment_attachments, [:comment_id, :attachment_id], :unique => true)
  end
end
