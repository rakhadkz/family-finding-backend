class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.text :logo
      t.text :website
      t.string :state
      t.string :zip
      t.string :city

      t.timestamps
    end
  end
end
