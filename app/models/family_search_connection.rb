class FamilySearchConnection < ApplicationRecord
  belongs_to :family_search
  belongs_to :child_contact
  validates :family_search_id, uniqueness: { scope: :child_contact_id }
  scope :filter_by_link_alerts, -> { where. not(family_search_id: nil) }
end
