class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :link
      t.integer :organization_id

      t.timestamps
    end
  end
end
