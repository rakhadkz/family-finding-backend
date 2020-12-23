class CreateUserChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :user_children do |t|
      t.references :user, foreign_key: true
      t.references :child, foreign_key: true
      t.boolean :approved

      t.timestamps
    end
  end
end
