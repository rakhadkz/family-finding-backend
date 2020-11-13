class Attachment < ApplicationRecord
  has_and_belongs_to_many :children
  has_and_belongs_to_many :comments
  has_and_belongs_to_many :findings
end
