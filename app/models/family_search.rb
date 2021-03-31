class FamilySearch < ApplicationRecord
  belongs_to :user
  belongs_to :search_vector
  belongs_to :child
  belongs_to :child_contact

  has_many :family_search_attachments
  has_many :attachments, through: :family_search_attachments

  has_many :family_search_connections
  has_many :child_contacts, through: :family_search_connections

  scope :filter_by_search_vector_for_job, -> (id){ where(search_vector_id: id, date_accepted: nil, date_rejected: nil) }

  scope :only_link_alerts, -> { where( is_link_alert: true )}

  scope :not_rejected, -> { where(date_rejected: nil) }
end
