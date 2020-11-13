class User < ApplicationRecord

  has_many :comments

  belongs_to :organization

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
         :trackable, :lockable

  enum role: {
    super_admin: 'super_admin',
    admin: 'admin',
    manager: 'manager',
    user: 'user'
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
