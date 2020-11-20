class Child < ApplicationRecord
  has_many :attachments
  has_many :findings
  has_many :search_vectors, through: :findings

  has_many :child_contacts
  has_many :contacts, :through => :child_contacts

  has_many :child_attachments
  has_many :attachments, :through => :child_attachments

  has_many :siblingships
  has_many :siblings, :through => :siblingships

  has_many :inverse_siblingships, :class_name => 'Siblingship', :foreign_key => 'sibling_id'
  has_many :inverse_siblings, :through => :inverse_siblingships, :source => :child

  has_many :action_items

  enum continuous_search: { Yes: "Yes", No: "No"}

  def all_siblings
    self.siblings + self.inverse_siblings
  end
end
