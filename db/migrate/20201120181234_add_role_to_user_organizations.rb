class AddRoleToUserOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_organizations, :role, :string, null: false, default: 'user'
  end
end
