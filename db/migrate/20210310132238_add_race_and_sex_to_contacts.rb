class AddRaceAndSexToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :race, :string
    add_column :contacts, :sex, :string
  end
end
