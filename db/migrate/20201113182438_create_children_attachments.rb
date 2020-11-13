class CreateChildrenAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :children_attachments do |t|
      t.belongs_to :child
      t.belongs_to :attachment
      t.timestamps
    end
  end
end
