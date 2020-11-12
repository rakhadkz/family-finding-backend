class CreateFindings < ActiveRecord::Migration[6.0]
  def change
    create_table :findings do |t|
      t.references :child, foreign_key: true
      t.references :search_vector, foreign_key: true
      t.references :user, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
