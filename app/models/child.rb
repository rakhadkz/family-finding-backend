class Child < ApplicationRecord
  has_many :attachments
  has_and_belongs_to_many :contacts
end
