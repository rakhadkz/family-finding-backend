class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  scope :filter_by_user_id, -> (user_id) { where user_id: user_id}
  scope :filter_by_organization_id, -> (organization_id) { where organization_id: organization_id}

  enum role: {
    super_admin: 'super_admin',
    admin: 'admin',
    manager: 'manager',
    user: 'user'
  }
end
