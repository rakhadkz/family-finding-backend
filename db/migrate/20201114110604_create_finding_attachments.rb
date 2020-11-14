class CreateFindingAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :finding_attachments do |t|
      t.belongs_to :finding
      t.belongs_to :attachment
      t.timestamps
    end

    add_index(:finding_attachments, [:finding_id, :attachment_id], :unique => true)
  end
end
