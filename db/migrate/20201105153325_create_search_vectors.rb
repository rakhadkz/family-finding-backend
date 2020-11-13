class CreateSearchVectors < ActiveRecord::Migration[6.0]
  def change
    create_table :search_vectors do |t|
      t.string :name
      t.text :description
      t.boolean :in_continuous_search

      t.timestamps
    end
  end
end
