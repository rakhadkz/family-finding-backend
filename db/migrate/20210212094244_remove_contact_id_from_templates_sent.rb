class RemoveContactIdFromTemplatesSent < ActiveRecord::Migration[6.0]
  def change
    remove_column :templates_sents, :contact_id, :bigint
    remove_column :templates_sents, :child_id, :bigint
  end
end
