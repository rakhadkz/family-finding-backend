class FamilySearchConnection < ApplicationRecord
  belongs_to :family_search
  belongs_to :child_contact
end
