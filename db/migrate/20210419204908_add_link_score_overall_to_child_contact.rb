class AddLinkScoreOverallToChildContact < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :link_score_overall, :integer
  end
end
