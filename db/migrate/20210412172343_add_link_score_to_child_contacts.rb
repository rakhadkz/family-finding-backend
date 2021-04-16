class AddLinkScoreToChildContacts < ActiveRecord::Migration[6.0]
  def change
    add_reference :child_contacts, :link_score, foreign_key: true
  end
end
