class AddAddressToSchoolDistricts < ActiveRecord::Migration[6.0]
  def change
    remove_column :contacts, :address
    remove_column :contacts, :address_2
    remove_column :child_contacts, :family_fit_score
    add_reference :school_districts, :address, foreign_key: true
    add_reference :contacts, :address, foreign_key: true
  end
end
