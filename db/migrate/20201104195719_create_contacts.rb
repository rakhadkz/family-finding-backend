class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.string :email
      t.string :phone
      t.string :zip

      t.timestamps
    end
  end
end
