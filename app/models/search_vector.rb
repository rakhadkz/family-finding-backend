class SearchVector < ApplicationRecord
  has_many :findings
  has_many :children, through: :findings
  belongs_to :organization

  include PgSearch::Model

  pg_search_scope :search,
    against: [
      :name, :description
    ],
    using: {
      tsearch: {prefix: true}
    }

end
