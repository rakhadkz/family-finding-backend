class User < ApplicationRecord
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
    admin: 'admin',
    user: 'user',
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
