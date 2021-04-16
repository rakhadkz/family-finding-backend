class SearchVector < ApplicationRecord
  has_many :findings
  has_many :children, through: :findings
  belongs_to :organization

  has_many :family_searches

  include PgSearch::Model

  scope :filter_by_org_id, -> (org_id) { where(organization_id: org_id) }

  pg_search_scope :search,
    against: [
      :name, :description
    ],
    using: {
      tsearch: {prefix: true}
    }

end
