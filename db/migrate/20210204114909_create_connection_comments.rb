class CreateConnectionComments < ActiveRecord::Migration[6.0]
  def change
    create_table :connection_comments do |t|
      t.references :contact, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
