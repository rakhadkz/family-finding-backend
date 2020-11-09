class AddStateToOrganization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :state, :string
    add_column :organizations, :zip, :string
    add_column :organizations, :city, :string
  end
end
