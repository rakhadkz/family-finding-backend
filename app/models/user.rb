class User < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :findings, dependent: :destroy
  has_many :action_items, dependent: :destroy

  has_many :user_organizations, dependent: :destroy
  has_many :organizations, through: :user_organizations

  has_many :attachments, dependent: :destroy

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
