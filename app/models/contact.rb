class Contact < ApplicationRecord
  has_many :child_contacts
  has_many :children, through: :child_contacts

  has_many :child_tree_contacts
  has_many :children, through: :child_tree_contacts
end
