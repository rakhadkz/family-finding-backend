class AddFamilyFitScoreAndPotentialMatchToChildContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :child_contacts, :family_fit_score, :integer, default: 0
    add_column :child_contacts, :potential_match, :boolean, default: false
  end
end
