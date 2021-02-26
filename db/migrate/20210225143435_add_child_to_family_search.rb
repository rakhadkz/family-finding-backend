class AddChildToFamilySearch < ActiveRecord::Migration[6.0]
  def change
    add_reference :family_searches, :child, foreign_key: true
  end
end
