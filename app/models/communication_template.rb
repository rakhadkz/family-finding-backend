class CommunicationTemplate < ApplicationRecord

  scope :filter_by_organization_id, -> (organization_id) { where organization_id: organization_id}

  enum template_type: {
    "SMS": "sms",
    "Letter": "letter",
    "Email": "email"
  }

end
