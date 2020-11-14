class CreateChildAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :child_attachments do |t|
      t.belongs_to :child
      t.belongs_to :attachment
      t.timestamps
    end

    add_index(:child_attachments, [:child_id, :attachment_id], :unique => true)
  end
end
