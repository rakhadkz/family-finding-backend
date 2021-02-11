class TemplatesSent < ApplicationRecord
  belongs_to :communication_template
  belongs_to :contact
  belongs_to :child

  scope :filter_by_contact_id, -> (contact_id) { where contact_id: contact_id}
end
