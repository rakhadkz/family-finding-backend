class Child < ApplicationRecord
  has_many :attachments
  has_many :findings
  has_many :search_vectors, through: :findings

  has_many :contact_children
  has_many :contacts, :through => :contact_children

  has_many :child_attachments
  has_many :attachments, :through => :child_attachments

  has_many :siblingships
  has_many :siblings, :through => :siblingships

  has_many :inverse_siblingships, :class_name => 'Siblingship', :foreign_key => 'sibling_id'
  has_many :inverse_siblings, :through => :inverse_siblingships, :source => :child
end
