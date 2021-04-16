class Organization < ApplicationRecord
  has_many :user_organizations
  has_one  :twilio_phone_number
  has_many :users, through: :user_organizations
  has_many :search_vectors, dependent: :destroy

  include PgSearch::Model

  pg_search_scope :search,
    against: [
      :name, :address, :state, :city
    ],
    using: {
      tsearch: {prefix: true}
    }
end
