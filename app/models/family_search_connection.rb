class FamilySearchConnection < ApplicationRecord
  belongs_to :family_search
  belongs_to :child_contact
  validates :family_search_id, uniqueness: { scope: :child_contact_id }
end
