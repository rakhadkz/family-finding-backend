class Finding < ApplicationRecord
  belongs_to :child
  belongs_to :search_vector
  belongs_to :user
  has_and_belongs_to_many :attachments
end
