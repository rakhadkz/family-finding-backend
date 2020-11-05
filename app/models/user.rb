class User < ApplicationRecord

  has_many :comments

  scope :filter_by_role, -> (role) { where role: role}

  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :first_name,
                    :last_name,
                    :role,
                    :email
                  ],
                  using: {
                    tsearch: {prefix: true}
                  }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :lockable

  enum role: {
    admin: 'organization_admin',
    user: 'user',

    super_admin: 'super_admin',
    organization_admin: 'organization_admin',
    organization_manager: 'organization_manager',
    organization_user: 'organization_user'
  }

  def token
    JsonWebToken.encode(
      {
        user_id: id,
        email: email,
        first_name: first_name,
        last_name: last_name,
        role: role
      }, 6.weeks.from_now.to_i)
  end
end
