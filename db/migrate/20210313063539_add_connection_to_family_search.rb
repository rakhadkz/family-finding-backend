class AddConnectionToFamilySearch < ActiveRecord::Migration[6.0]
  def change
    add_reference :family_searches, :child_contact, foreign_key: true
  end
end
