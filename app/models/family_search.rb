class FamilySearch < ApplicationRecord
  belongs_to :user
  belongs_to :search_vector
  belongs_to :child
  belongs_to :child_contact

  has_many :family_search_attachments
  has_many :attachments, through: :family_search_attachments

  has_many :family_search_connections
  has_many :child_contacts, through: :family_search_connections
end
