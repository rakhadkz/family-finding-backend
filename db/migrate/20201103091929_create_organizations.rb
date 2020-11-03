class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.text :logoUrl
      t.text :website

      t.timestamps
    end
  end
end
