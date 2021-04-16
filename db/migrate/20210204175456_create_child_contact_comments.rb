class CreateChildContactComments < ActiveRecord::Migration[6.0]
  def change
    create_table :child_contact_comments do |t|
      t.references :child_contact, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
