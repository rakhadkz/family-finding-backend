class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.bigint :in_reply_to

      t.timestamps
    end
  end
end
