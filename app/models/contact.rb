class Contact < ApplicationRecord
  has_many :child_contacts
  has_many :children, through: :child_contacts

  has_many :child_tree_contacts
  has_many :children, through: :child_tree_contacts

  has_many :connection_attachments
  has_many :attachments, through: :connection_attachments

  has_many :connection_comments
  has_many :comments, through: :connection_comments
end
