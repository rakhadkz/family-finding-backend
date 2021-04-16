class AddChildContactToLinkScores < ActiveRecord::Migration[6.0]
  def change
    add_reference :link_scores, :child_contact, foreign_key: true
    remove_column :child_contacts, :link_score_id
  end
end
