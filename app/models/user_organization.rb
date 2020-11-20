class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum role: {
    super_admin: 'super_admin',
    admin: 'admin',
    manager: 'manager',
    user: 'user'
  }
end
