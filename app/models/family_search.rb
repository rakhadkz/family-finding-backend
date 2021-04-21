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

  scope :only_link_alerts, -> { joins(:search_vector).where(search_vectors: { task_id: ["qfpI8LT6l00ylR9dT", "AAn4h8mfBNaKk33Rb", "4DsuaZNZ7u3zSmdqy"] })}

  scope :not_rejected, -> { where(date_rejected: nil) }
end
