class AddVerifiedEmploymentAndAccessToTransportationToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :verified_employment, :boolean
    add_column :contacts, :access_to_transportation, :boolean
  end
end
