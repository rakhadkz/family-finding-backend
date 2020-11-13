class CreateFindingsAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :findings_attachments do |t|
      t.belongs_to :finding
      t.belongs_to :attachment
      t.timestamps
    end
  end
end
