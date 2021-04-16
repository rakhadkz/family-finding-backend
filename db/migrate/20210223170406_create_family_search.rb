class CreateFamilySearch < ActiveRecord::Migration[6.0]
  def change
    create_table :family_searches do |t|
      t.references :user, foreign_key: true
      t.references :search_vector, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
