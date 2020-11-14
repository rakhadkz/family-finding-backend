class Contact < ApplicationRecord
  has_many :contact_children
  has_many :children, :through => :contact_children
end
