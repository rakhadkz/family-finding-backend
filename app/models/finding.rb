class Finding < ApplicationRecord
  belongs_to :child
  belongs_to :search_vector
  belongs_to :user
  has_many :finding_attachments
  has_many :attachments, :through =>  :finding_attachments
end
