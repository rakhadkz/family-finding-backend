class Resource < ApplicationRecord
    scope :filter_by_organization_id, -> (organization_id)  { where(organization_id: organization_id).or(where organization_id: nil)}
end
