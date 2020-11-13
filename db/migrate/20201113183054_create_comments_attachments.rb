class CreateCommentsAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments_attachments do |t|
      t.belongs_to :comment
      t.belongs_to :attachment
      t.timestamps
    end
  end
end
