class TemplatesSent < ApplicationRecord
  belongs_to :communication_template
  belongs_to :child_contact

  scope :filter_by_organization_id, -> (id) { where(communication_templates: { organization_id: id })}
end
