class Contact < ApplicationRecord
  has_many :child_contacts
  has_many :children, through: :child_contacts

  belongs_to :parent, class_name: "Contact", foreign_key: :parent_id
  has_many :children, class_name: "Contact", foreign_key: :parent_id
end
